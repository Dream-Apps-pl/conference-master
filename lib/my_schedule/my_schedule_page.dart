import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:conferenceapp/agenda/bloc/bloc.dart';
import 'package:conferenceapp/agenda/day_selector.dart';
import 'package:conferenceapp/agenda/helpers/agenda_layout_helper.dart';
import 'package:conferenceapp/agenda/widgets/new_populated_agenda_list.dart';
import 'package:conferenceapp/agenda/widgets/new_populated_agenda_table.dart';
import 'package:conferenceapp/model/agendas.dart';
import 'package:conferenceapp/model/talk.dart';
import 'package:conferenceapp/profile/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class MySchedulePage extends StatefulWidget {
  @override
  _MySchedulePageState createState() => _MySchedulePageState();
}

class _MySchedulePageState extends State<MySchedulePage> {
  late PageController pageController;
  final ValueNotifier<int> currentIndex = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
    pageController.addListener(() {
      if (pageController.page?.round() != currentIndex.value) {
        currentIndex.value = pageController.page!.round();
      }
    });
    currentIndex.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (pageController.hasClients)
          DaySelectorContainer(pageController, currentIndex.value),
        Flexible(
          child: StreamBuilder<List<dynamic>>(
            stream: RepositoryProvider.of<AuthRepository>(context).favorites(),
            builder: (context, snapshotFavorite) {
              List<String> fav = snapshotFavorite.data == null
                  ? []
                  : List<String>.from(
                      snapshotFavorite.data as List,
                    );
              return FirestoreBuilder<TalkQuerySnapshot>(
                ref: talksRef,
                builder: (BuildContext context,
                    AsyncSnapshot<TalkQuerySnapshot> snapshot, Widget? child) {
                  if (snapshot.hasError) {
                    return Center(
                        child: Text('An error has occured! ${snapshot.error}'));
                  }
                  if (snapshot.hasData) {
                    TalkQuerySnapshot talkSnapshot = snapshot.requireData;
                    final layoutHelper =
                        Provider.of<AgendaLayoutHelper>(context);
                    final compact = layoutHelper.isCompact();
                    final data = talkSnapshot.docs
                        .where((element) => fav.contains(element.data.id))
                        .toList();
                    if (data.isEmpty) {
                      return MyScheduleEmptyState();
                    }
                    return PageView(
                      controller: pageController,
                      physics: AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics()),
                      children: <Widget>[
                        NewPopulatedAgendaDayListContent(
                          favoriteTalks: fav,
                          compact: compact,
                          layoutHelper: layoutHelper,
                          snapshot: talkSnapshot.docs
                              .where((element) =>
                                  element.data.day == DayType.one &&
                                  fav.contains(element.data.id))
                              .toList(),
                        ),
                        NewPopulatedAgendaDayListContent(
                          favoriteTalks: fav,
                          compact: compact,
                          layoutHelper: layoutHelper,
                          snapshot: talkSnapshot.docs
                              .where((element) =>
                                  element.data.day == DayType.two &&
                                  fav.contains(element.data.id))
                              .toList(),
                        ),
                      ],
                    );
                    // return Text("${talkSnapshot.docs.first.data.title}");
                  }
                  return MyScheduleEmptyState();
                },
              );
            },
          ),
        ),
        // Flexible(
        //   child: FirestoreBuilder<AgendasQuerySnapshot>(
        //     ref: agendasRef,
        //     builder: (BuildContext context,
        //         AsyncSnapshot<AgendasQuerySnapshot> snapshot, Widget? child) {
        //       if (snapshot.hasData) {
        //         AgendasQuerySnapshot agendaSnapshot = snapshot.requireData;
        //         return NewPopulatedAgendaTable(
        //           agendaSnapshot,
        //           pageController,
        //         );
        //       }
        //       return MyScheduleEmptyState();
        //     },
        //   ),
        // ),
        // Flexible(
        //   child: BlocBuilder(
        //     bloc: BlocProvider.of<AgendaBloc>(context),
        //     builder: (context, AgendaState state) {
        //       return StreamBuilder<List<Talk>>(
        //         stream: favoritesRepository.favoriteTalks,
        //         builder: (context, snapshot) {
        //           if (state is PopulatedAgendaState &&
        //               snapshot.hasData &&
        //               snapshot.data!.length > 0) {
        //             final talksMap = getTalksPerDay(snapshot, state);
        //             return PopulatedAgendaTable(
        //               talksMap,
        //               state.rooms,
        //               pageController,
        //               skipWidgetPreload: true,
        //             );
        //           }
        //           return MyScheduleEmptyState();
        //         },
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }

  getTalksPerDay(
      AsyncSnapshot<List<Talk>> snapshot, PopulatedAgendaState state) {
    final talks = {
      0: snapshot.data!
          .where((f) => sameDay(f.startTime, state.talks[0]!.first.startTime))
          .toList()
        ..sort(),
      1: snapshot.data!
          .where((f) => sameDay(f.startTime, state.talks[1]!.first.startTime))
          .toList()
        ..sort(),
    };
    return talks;
  }

  bool sameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}

class MyScheduleEmptyState extends StatelessWidget {
  const MyScheduleEmptyState({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/no_data.png',
            height: 200,
            width: 200,
            fit: BoxFit.contain,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Here you will see your observed talks'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Add some by tapping ❤️'),
          ),
        ],
      ),
    );
  }
}
