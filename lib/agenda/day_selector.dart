import 'package:conferenceapp/agenda/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:conferenceapp/generated/l10n.dart';

class DaySelectorContainer extends StatelessWidget {
  const DaySelectorContainer(
    this.pageController,
    this.index, {
    Key? key,
  }) : super(key: key);

  final PageController pageController;
  final int index;

  @override
  Widget build(BuildContext context) {
    final bgColor = Theme.of(context).brightness == Brightness.light
        ? Colors.blue[100]
        : Colors.blue[900];

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: bgColor!,
                      style: BorderStyle.solid,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              DaySelector(bgColor, pageController, index),
            ],
          ),
        ),
      ),
    );
  }
}

class DaySelector extends StatelessWidget {
  const DaySelector(
    this.bgColor,
    this.pageController,
    this.index, {
    Key? key,
  }) : super(key: key);

  final Color bgColor;
  final PageController pageController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgendaBloc, AgendaState>(
      builder: (context, state) {
        final selectedDay = index;

        return Stack(
          children: <Widget>[
            AnimatedPositioned(
              top: 0,
              bottom: 0,
              left: selectedDay == 0
                  ? 0
                  : selectedDay == 1
                      ? (MediaQuery.of(context).size.width - 24) / 3
                      : (MediaQuery.of(context).size.width - 24) / 1.5,
              right: selectedDay == 0
                  ? (MediaQuery.of(context).size.width - 24) / 1.5
                  : selectedDay == 1
                      ? (MediaQuery.of(context).size.width - 24) / 3
                      : 0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
              child: Container(
                color: bgColor,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Material(
                    type: MaterialType.transparency,
                    child: Semantics(
                      button: true,
                      enabled: selectedDay != 0,
                      hint: S.current.selectDayNo1,
                      child: InkWell(
                        onTap: () {
                          pageController.animateToPage(
                            0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Center(
                            child: Text(
                              S.of(context).day1,
                              style: TextStyle(
                                color: selectedDay == 0
                                    ? Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Theme.of(context).primaryColor
                                        : Colors.white
                                    : Theme.of(context).brightness ==
                                            Brightness.light
                                        ? bgColor
                                        : Colors.grey[300],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    type: MaterialType.transparency,
                    child: Semantics(
                      button: true,
                      enabled: selectedDay == 1,
                      hint: S.of(context).selectDayNo2,
                      child: InkWell(
                        onTap: () {
                          pageController.animateToPage(
                            1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Center(
                            child: Text(
                              S.of(context).day2,
                              style: TextStyle(
                                color: selectedDay != 0 && selectedDay != 2
                                    ? Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Theme.of(context).primaryColor
                                        : Colors.white
                                    : Theme.of(context).brightness ==
                                            Brightness.light
                                        ? bgColor
                                        : Colors.grey[300],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    type: MaterialType.transparency,
                    child: Semantics(
                      button: true,
                      enabled: selectedDay == 2,
                      hint: S.of(context).selectDayNo3,
                      child: InkWell(
                        onTap: () {
                          pageController.animateToPage(
                            2,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Center(
                            child: Text(
                              S.of(context).day3,
                              style: TextStyle(
                                color: selectedDay != 0 && selectedDay != 1
                                    ? Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Theme.of(context).primaryColor
                                        : Colors.white
                                    : Theme.of(context).brightness ==
                                            Brightness.light
                                        ? bgColor
                                        : Colors.grey[300],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
