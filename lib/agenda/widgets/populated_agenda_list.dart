import 'package:collection/collection.dart';
import 'package:conferenceapp/agenda/helpers/agenda_layout_helper.dart';
import 'package:conferenceapp/agenda/widgets/talk_card.dart';
import 'package:conferenceapp/model/room.dart';
import 'package:conferenceapp/model/talk.dart';
import 'package:conferenceapp/profile/favorites_repository.dart';
import 'package:conferenceapp/talk/talk_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'animated_room_indicator.dart';
import 'talk_hour.dart';

class PopulatedAgendaDayList extends StatelessWidget {
  const PopulatedAgendaDayList(
    this.talksInDay,
    this.rooms, {
    Key? key,
  }) : super(key: key);

  final List<Talk> talksInDay;
  final List<Room> rooms;

  @override
  Widget build(BuildContext context) {
    final talksPerHour =
        groupBy<Talk, DateTime>(talksInDay, (t) => t.startTime);

    final favoritesRepository =
        RepositoryProvider.of<FavoritesRepository>(context);
    return StreamBuilder<List<Talk>>(
      stream: favoritesRepository.favoriteTalks,
      builder: (context, snapshot) {
        final layoutHelper = Provider.of<AgendaLayoutHelper>(context);
        final compact = layoutHelper.isCompact();
        return Stack(
          children: <Widget>[
            PopulatedAgendaDayListContent(
              talksPerHour: talksPerHour,
              rooms: rooms,
              compact: compact,
              layoutHelper: layoutHelper,
              snapshot: snapshot,
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AnimatedRoomIndicator(
                compact: compact,
                rooms: rooms,
              ),
            ),
          ],
        );
      },
    );
  }
}

class PopulatedAgendaDayListContent extends StatelessWidget {
  const PopulatedAgendaDayListContent({
    Key? key,
    required this.talksPerHour,
    required this.compact,
    required this.layoutHelper,
    required this.snapshot,
    required this.rooms,
  }) : super(key: key);

  final Map<DateTime, List<Talk>> talksPerHour;
  final List<Room> rooms;
  final bool compact;
  final AgendaLayoutHelper layoutHelper;
  final AsyncSnapshot<List<Talk>> snapshot;

  @override
  Widget build(BuildContext context) {
    final hours = talksPerHour.keys.toList();

    if (hours.isEmpty) {
      return const Center(
        child: Text('No talks on this day'),
      );
    }
    final favoriteTalks = snapshot.data ?? [];

    final listCompact = compact
        ? ListView.builder(
            padding: const EdgeInsets.only(
              left: 12.0,
              right: 12.0,
              top: 16.0,
              bottom: 62.0,
            ),
            physics:
                const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            itemCount: talksPerHour.length,
            itemBuilder: (context, index) {
              Talk firstTalk;
              Talk secondTalk;

              final thisHoursTalks = talksPerHour[hours[index]];

              //TODO: make it independent of rooms number
              firstTalk = thisHoursTalks!.firstWhere(
                (t) => t.room.id != TalkType.advanced.toString(),
              );
              secondTalk = thisHoursTalks.firstWhere(
                (t) => t.room.id == TalkType.advanced.toString(),
              );

              final firstChild = getCompactTalkCards(
                  firstTalk, secondTalk, favoriteTalks, context);

              return Container(
                child: firstChild,
              );
            },
          )
        : Container();

    final listNormal = compact
        ? Container()
        : ListView.builder(
            padding: const EdgeInsets.only(
              left: 12.0,
              right: 12.0,
              top: 16.0,
              bottom: 62.0,
            ),
            physics:
                const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            itemCount: talksPerHour.length,
            itemBuilder: (context, index) {
              Talk firstTalk;
              Talk secondTalk;

              final thisHoursTalks = talksPerHour[hours[index]];

              //TODO: make it independent of rooms number
              firstTalk = thisHoursTalks!.firstWhere(
                (t) => t.room.id != TalkType.advanced.toString(),
              );
              secondTalk = thisHoursTalks.firstWhere(
                (t) => t.room.id == TalkType.advanced.toString(),
              );

              final secondChild = getNormalTalkCards(
                  firstTalk, favoriteTalks, context, secondTalk);

              return Container(
                child: secondChild,
              );
            },
          );

    return AnimatedCrossFade(
      duration: const Duration(milliseconds: 400),
      crossFadeState:
          compact ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      firstChild: listCompact,
      secondChild: listNormal,
    );
  }

  Column getNormalTalkCards(Talk firstTalk, List<Talk> favoriteTalks,
      BuildContext context, Talk secondTalk) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (firstTalk.id.isNotEmpty)
          TalkCard(
            key: ValueKey(firstTalk.id),
            talk: firstTalk,
            isFavorite: favoriteTalks.any((t) => t.id == firstTalk.id),
            first: true,
            compact: false,
            onTap: () => onTap(context, firstTalk),
          ),
        if (secondTalk.id.isNotEmpty)
          TalkCard(
            key: ValueKey(secondTalk.id),
            talk: secondTalk,
            isFavorite: favoriteTalks.any((t) => t.id == secondTalk.id),
            first: false,
            compact: false,
            onTap: () => onTap(context, secondTalk),
          ),
      ],
    );
  }

  Row getCompactTalkCards(Talk firstTalk, Talk secondTalk,
      List<Talk> favoriteTalks, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CompactLeftTalkContainer(talk: firstTalk),
        if (firstTalk.type == TalkType.other)
          Expanded(
            child: TalkCard(
              key: ValueKey(firstTalk.id),
              talk: firstTalk,
              isFavorite: favoriteTalks.any((t) => t.id == firstTalk.id),
              first: true,
              compact: true,
              onTap: () => onTap(context, firstTalk),
            ),
          )
        else if (firstTalk.type == TalkType.beginner)
          Flexible(
            child: TalkCard(
              key: ValueKey(firstTalk.id),
              talk: firstTalk,
              isFavorite: favoriteTalks.any((t) => t.id == firstTalk.id),
              first: true,
              compact: true,
              onTap: () => onTap(context, firstTalk),
            ),
          )
        else
          Flexible(child: Container()),
        if (firstTalk.type != TalkType.other)
          const SizedBox(
            width: 12,
          ),
        if (secondTalk.type == TalkType.advanced)
          Flexible(
            child: TalkCard(
              key: ValueKey(secondTalk.id),
              talk: secondTalk,
              isFavorite: favoriteTalks.any((t) => t.id == secondTalk.id),
              first: false,
              compact: true,
              onTap: () => onTap(context, secondTalk),
            ),
          )
        else if (firstTalk.type != TalkType.other)
          Flexible(child: Container()),
      ],
    );
  }

  void onTap(BuildContext context, Talk talk) {
    if (talk.type == TalkType.other) {
      return;
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TalkPage(talk),
          settings: RouteSettings(name: 'agenda/${talk.id}'),
        ),
      );
    }
  }
}
