import 'package:conferenceapp/agenda/bloc/bloc.dart';
import 'package:conferenceapp/agenda/repository/talks_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'day_selector.dart';
import 'widgets/loading_agenda_table.dart';
import 'widgets/populated_agenda_table.dart';

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
    RepositoryProvider.of<TalkRepository>(context).talks();
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
          child: BlocBuilder(
            bloc: BlocProvider.of<AgendaBloc>(context),
            builder: (context, AgendaState state) =>
                state is PopulatedAgendaState
                    ? PopulatedAgendaTable(
                        state.talks,
                        state.rooms,
                        pageController,
                      )
                    : LoadingAgendaTable(),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
