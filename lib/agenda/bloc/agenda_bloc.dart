import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:conferenceapp/agenda/repository/talks_repository.dart';

import './bloc.dart';

class AgendaBloc extends Bloc<AgendaEvent, AgendaState> {
  AgendaBloc(this.talksRepository) : super(InitialAgendaState()) {
    on<AgendaEvent>((event, emit) => mapEventToState(InitAgenda()));
  }

  @override
  String toString() => 'AgendaBloc';

  late TalkRepository talksRepository;
  late StreamSubscription talksSubscription;

  AgendaState get initialState => InitialAgendaState();

  Stream<AgendaState> mapEventToState(
    AgendaEvent event,
  ) async* {
    print('log apa ${event}');
    if (event is InitAgenda) {
      yield* mapInitToState(event);
    }
    if (event is AgendaUpdated) {
      yield* mapUpdateToState(event);
    }
    if (event is FetchAgenda) {
      yield* mapFetchToState(event);
    }
  }

  Stream<AgendaState> mapInitToState(InitAgenda event) async* {
    print('log gaskeun');
    yield LoadingAgendaState();
    talksSubscription.cancel();
    talksSubscription = talksRepository.talks().listen(
      (talks) {
        print('log talks $talks');
        add(AgendaUpdated(talks));
      },
    );
  }

  Stream<AgendaState> mapUpdateToState(AgendaUpdated event) async* {
    if (event.talks.isNotEmpty) {
      if (event.talks.length == 0) {
        yield LoadingAgendaState();
      }
      yield PopulatedAgendaState(event.talks);
    }
  }

  Stream<AgendaState> mapFetchToState(FetchAgenda event) async* {
    talksRepository.refresh();
  }

  @override
  Future<void> close() {
    talksSubscription.cancel();
    return super.close();
  }
}
