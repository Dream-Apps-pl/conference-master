import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conferenceapp/common/logger.dart';
import 'package:conferenceapp/model/ticket.dart';
import './bloc.dart';

class TicketCheckBloc extends Bloc<TicketCheckEvent, TicketCheckState> {
  final ticketCollection = FirebaseFirestore.instance.collection('tickets');
  final checkedTickets =
      FirebaseFirestore.instance.collection('tickets_checked');
  final users = FirebaseFirestore.instance.collection('users');

  TicketCheckBloc() : super(NoTicketCheckState());

  @override
  String toString() => 'TicketCheckBloc';

  TicketCheckState get initialState => NoTicketCheckState();

  Stream<TicketCheckState> mapEventToState(
    TicketCheckEvent event,
  ) async* {
    if (event is InitEvent) {
      yield NoTicketCheckState();
    }
    if (event is TicketScanned) {
      yield* handleTicketScanned(event);
    }

    if (event is TickedValidated) {
      yield* handleTicketValidated(event);
    }
  }

  Stream<TicketCheckState> handleTicketValidated(TickedValidated event) async* {
    try {
      yield LoadingState();
      if (event.userId.isNotEmpty) await updateUser(event);
      await addToCheckedTickets(event);

      yield TicketValidatedState(event.ticket, event.userId);
    } catch (e) {
      logger.errorException(e);
      yield TicketErrorState('Error during marking as present.');
    }
  }

  Future addToCheckedTickets(TickedValidated event) async {
    await checkedTickets.doc(event.ticket.ticketId).set({
      'userId': event.userId,
      'ticketId': event.ticket.ticketId,
      'orderId': event.ticket.orderId,
      'updated': DateTime.now(),
    });
  }

  Future updateUser(TickedValidated event) async {
    final user = users.doc(event.userId);
    await user.set({
      'ticketId': event.ticket.ticketId,
      'orderId': event.ticket.orderId,
      'updated': DateTime.now(),
    }, SetOptions(merge: true));
  }

  Stream<TicketCheckState> handleTicketScanned(TicketScanned event) async* {
    yield LoadingState();
    try {
      final values = event.valueRead.split(' ');
      final userId = values[0];
      final orderId = values[1].contains('OT')
          ? values[1].substring(2).toUpperCase()
          : values[1].toUpperCase();
      final ticketId = values[2];
      final matchingTickets = await getMatchingTickets(orderId, ticketId);

      if (matchingTickets.isNotEmpty) {
        final matchingCheckedTickets =
            await getMatchingCheckedTickets(matchingTickets);
        if (matchingCheckedTickets.length == matchingTickets.length) {
          yield TicketErrorState(
              'Wszystkie bilety z zam??wienia $orderId zosta??y ju?? sprawdzone. W zam??wieniu by??o ${matchingTickets.length} bilet??w. Skonsultuj sytuacj?? z osob?? odpowiedzialn?? za sprawdzanie bilet??w.\nSprawdzone bilety:\n${matchingCheckedTickets.map((m) => m['orderId'] + ' ' + m['ticketId']).join('\n')}');
          return;
        }
        final matchingTicketsWithoutChecked = [];
        filterCheccked(matchingTickets, matchingCheckedTickets,
            matchingTicketsWithoutChecked);
        final selectedTicket = matchingTicketsWithoutChecked.first;
        logger.info(selectedTicket.toString());

        final matchingOrderId = selectedTicket['orderId'];
        final matchingTicketId = selectedTicket['ticketId'];
        final matchingName = selectedTicket['name'];
        final matchingType = selectedTicket['type'];

        final name = utf8.decode(base64Decode(matchingName));
        yield TicketScannedState(
          Ticket(matchingOrderId, matchingTicketId),
          userId,
          name,
          matchingType == 'Student',
          matchingTickets.length,
          matchingTicketsWithoutChecked.length,
          selectedTicket['used'],
        );
      } else {
        yield TicketErrorState(
            'Brak bilet??w o numerze zam??wienia: $orderId lub biletu: $ticketId.');
      }
    } catch (e) {
      logger.errorException(e);
      yield TicketErrorState(
          'Wyst??pi?? problem z odczytaniem lub znalezieniem pasujacego biletu. Spr??buj ponownie.');
    }
  }

  void filterCheccked(List matchingTickets, List matchingCheckedTickets,
      List matchingTicketsWithoutChecked) {
    for (var n in matchingTickets) {
      if (matchingCheckedTickets.firstWhere(
              (m) => m['ticketId'] == n['ticketId'],
              orElse: () => null) ==
          null) matchingTicketsWithoutChecked.add(n);
    }
    // return matchingTicketsWithoutChecked.first;
  }

  Future<List> getMatchingCheckedTickets(List matchingTickets) async {
    final mcts = await checkedTickets
        .where(
          'ticketId',
          whereIn: matchingTickets.map((f) => f['ticketId']).toList(),
        )
        .get();
    return mcts.docs;
  }

  Future<List> getMatchingTickets(String orderId, String ticketId) async {
    final ticketCollection = await getTicketsCollection();

    final checkByOrder = isCheckedByOrder(orderId);
    final matchigTickets = ticketCollection
        .where(checkByOrder
            ? (t) => t['orderId'] == orderId.toUpperCase()
            : (t) => t['ticketId'] == ticketId.toLowerCase())
        .toList();
    return matchigTickets;
  }

  bool isCheckedByOrder(String orderId) {
    return orderId.length > 1;
  }

  Future<List> getTicketsCollection() async {
    final tickets = await FirebaseFirestore.instance
        .doc('tickets/tickets')
        .snapshots()
        .first;

    final List ticketCollection = tickets.data()!['tickets'];
    return ticketCollection;
  }

}
