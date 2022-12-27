import 'package:conferenceapp/agenda/helpers/agenda_layout_helper.dart';
import 'package:conferenceapp/agenda/widgets/talk_card.dart';
import 'package:conferenceapp/agenda/widgets/talk_hour.dart';
import 'package:conferenceapp/model/agenda.dart';
import 'package:conferenceapp/model/talk.dart';
import 'package:conferenceapp/talk/talk_page.dart';
import 'package:flutter/material.dart';

class NewPopulatedAgendaDayListContent extends StatelessWidget {
  const NewPopulatedAgendaDayListContent({
    Key? key,
    required this.favoriteTalks,
    required this.compact,
    required this.layoutHelper,
    required this.snapshot,
  }) : super(key: key);

  // final List<Talk> talksPerHour;
  final List<String> favoriteTalks;
  final bool compact;
  final AgendaLayoutHelper layoutHelper;
  final List<TalkQueryDocumentSnapshot> snapshot;

  @override
  Widget build(BuildContext context) {
    // final hours = talksPerHour.keys.toList();

    // if (hours.isEmpty) {
    //   return Center(
    //     child: Text('No talks on this day'),
    //   );
    // }
    // final List<String> favoriteTalks = [];

    final listCompact = compact
        ? ListView.builder(
            padding: EdgeInsets.only(
              left: 12.0,
              right: 12.0,
              top: 16.0,
              bottom: 62.0,
            ),
            physics:
                AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            itemCount: snapshot.length,
            itemBuilder: (context, index) {
              Talk _firstTalk;
              Talk _secondTalk;

              final _thisHoursTalks = snapshot[index];

              //TODO: make it independent of rooms number
              // _firstTalk = _thisHoursTalks.data;
              _firstTalk = _thisHoursTalks.data;
              // .firstWhere(
              //   (t) => t.room.id != TalkType.advanced.toString(),
              // );
              _secondTalk = _thisHoursTalks.data;
              // .firstWhere(
              //   (t) => t.room.id == TalkType.advanced.toString(),
              // );

              final firstChild = getCompactTalkCards(
                  _firstTalk, _secondTalk, favoriteTalks, context);

              return Container(
                child: firstChild,
              );
            },
          )
        : Container();

    final listNormal = compact
        ? Container()
        : ListView.builder(
            padding: EdgeInsets.only(
              left: 12.0,
              right: 12.0,
              top: 16.0,
              bottom: 62.0,
            ),
            physics:
                AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            itemCount: snapshot.length,
            itemBuilder: (context, index) {
              Talk _firstTalk;
              Talk _secondTalk;

              final _thisHoursTalks = snapshot[index];

              //TODO: make it independent of rooms number
              _firstTalk = _thisHoursTalks.data;
              // .firstWhere(
              //   (t) => t.room.id != TalkType.advanced.toString(),
              // );
              _secondTalk = _thisHoursTalks.data;
              // .firstWhere(
              //   (t) => t.room.id == TalkType.advanced.toString(),
              // );

              final secondChild = getNormalTalkCards(
                  _firstTalk, favoriteTalks, context, _secondTalk);

              return Container(
                child: secondChild,
              );
            },
          );

    return AnimatedCrossFade(
      duration: Duration(milliseconds: 400),
      crossFadeState:
          compact ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      firstChild: listCompact,
      secondChild: listNormal,
    );
  }

  Column getNormalTalkCards(Talk _firstTalk, List<String> favoriteTalks,
      BuildContext context, Talk _secondTalk) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (_firstTalk != null)
          TalkCard(
            key: ValueKey(_firstTalk.id),
            talk: _firstTalk,
            isFavorite: favoriteTalks.contains(_firstTalk.id),
            first: true,
            compact: false,
            onTap: () => onTap(context, _firstTalk),
          ),
        // if (_secondTalk != null)
        //   TalkCard(
        //     key: ValueKey(_secondTalk.id),
        //     talk: _secondTalk,
        //     isFavorite: favoriteTalks.any((t) => t.id == _secondTalk.id),
        //     first: false,
        //     compact: false,
        //     onTap: () => onTap(context, _secondTalk),
        //   ),
      ],
    );
  }

  Row getCompactTalkCards(Talk _firstTalk, Talk _secondTalk,
      List<String> favoriteTalks, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CompactLeftTalkContainer(talk: _firstTalk),
        if (_firstTalk.type == TalkType.other)
          Expanded(
            child: TalkCard(
              key: ValueKey(_firstTalk.id),
              talk: _firstTalk,
              isFavorite: favoriteTalks.contains(_firstTalk.id),
              first: true,
              compact: true,
              onTap: () => onTap(context, _firstTalk),
            ),
          )
        else if (_firstTalk.type == TalkType.beginner)
          Flexible(
            child: TalkCard(
              key: ValueKey(_firstTalk.id),
              talk: _firstTalk,
              isFavorite: favoriteTalks.contains(_firstTalk.id),
              first: true,
              compact: true,
              onTap: () => onTap(context, _firstTalk),
            ),
          )
        else
          Flexible(child: Container()),
        if (_firstTalk.type != TalkType.other)
          SizedBox(
            width: 12,
          ),
        if (_secondTalk.type == TalkType.advanced)
          Flexible(
            child: TalkCard(
              key: ValueKey(_secondTalk.id),
              talk: _secondTalk,
              isFavorite: favoriteTalks.contains(_firstTalk.id),
              first: false,
              compact: true,
              onTap: () => onTap(context, _secondTalk),
            ),
          )
        else if (_firstTalk.type != TalkType.other)
          Flexible(child: Container()),
      ],
    );
  }

  void onTap(BuildContext context, Talk talk) {
    if (talk.type == TalkType.other)
      return;
    else
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TalkPage(talk),
          settings: RouteSettings(name: 'agenda/${talk.id}'),
        ),
      );
  }
}
