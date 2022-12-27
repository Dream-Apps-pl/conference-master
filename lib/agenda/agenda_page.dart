import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:conferenceapp/agenda/helpers/agenda_layout_helper.dart';
import 'package:conferenceapp/agenda/widgets/new_populated_agenda_list.dart';
import 'package:conferenceapp/model/talk.dart';
import 'package:conferenceapp/profile/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'day_selector.dart';
import 'widgets/loading_agenda_table.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({
    Key? key,
  }) : super(key: key);

  @override
  _AgendaPageState createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
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
              stream:
                  RepositoryProvider.of<AuthRepository>(context).favorites(),
              builder: (context, snapshotFavorite) {
                List<String> fav = snapshotFavorite.data == null
                    ? []
                    : List<String>.from(
                        snapshotFavorite.data as List,
                      );
                return FirestoreBuilder<TalkQuerySnapshot>(
                  ref: talksRef,
                  builder: (BuildContext context,
                      AsyncSnapshot<TalkQuerySnapshot> snapshot,
                      Widget? child) {
                    if (snapshot.hasError) {
                      return Center(
                          child:
                              Text('An error has occured! ${snapshot.error}'));
                    }
                    if (snapshot.hasData) {
                      TalkQuerySnapshot talkSnapshot = snapshot.requireData;
                      final layoutHelper =
                          Provider.of<AgendaLayoutHelper>(context);
                      final compact = layoutHelper.isCompact();
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
                                    element.data.day == DayType.one)
                                .toList(),
                          ),
                          NewPopulatedAgendaDayListContent(
                            favoriteTalks: fav,
                            compact: compact,
                            layoutHelper: layoutHelper,
                            snapshot: talkSnapshot.docs
                                .where((element) =>
                                    element.data.day == DayType.two)
                                .toList(),
                          ),
                        ],
                      );
                      // return Text("${talkSnapshot.docs.first.data.title}");
                    }
                    return LoadingAgendaTable();
                  },
                );
              }),
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
        //           isAgenda: true,
        //         );
        //       }
        //       return LoadingAgendaTable();
        //     },
        //   ),
        // ),
        // Flexible(
        //   child: BlocBuilder(
        //     bloc: BlocProvider.of<AgendaBloc>(context),
        //     builder: (context, AgendaState state) {
        //       print('log state $state');
        //       return state is PopulatedAgendaState
        //           ? PopulatedAgendaTable(
        //               state.talks,
        //               state.rooms,
        //               pageController,
        //             )
        //           : LoadingAgendaTable();
        //     },
        //   ),
        // ),
      ],
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
