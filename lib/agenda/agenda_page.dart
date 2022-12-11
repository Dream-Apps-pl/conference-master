import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conferenceapp/agenda/bloc/bloc.dart';
import 'package:conferenceapp/agenda/repository/talks_repository.dart';
import 'package:conferenceapp/agenda/widgets/talk_card.dart';
import 'package:conferenceapp/model/room.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'day_selector.dart';
import 'widgets/loading_agenda_table.dart';
import 'widgets/populated_agenda_table.dart';
import 'widgets/talk_card_widgets/talk_title.dart';

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
    // RepositoryProvider.of<TalkRepository>(context).talks();
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
            child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('talks').snapshots(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length ?? 0,
                  itemBuilder: (context, index) {
                    DocumentSnapshot doc = snapshot.data!.docs[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.all(5),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TalkTitleText(
                            title: doc['title'],
                            compact: false,
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    doc['authors'].first['avatar']),
                              ),
                              SizedBox(width: 10),
                              Text(doc['authors'].first['name'])
                            ],
                          )
                        ],
                      ),
                    );
                  });
            }
            return LoadingAgendaTable();
          }),
        ))
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
