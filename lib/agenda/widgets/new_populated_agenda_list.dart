import 'package:conferenceapp/agenda/helpers/agenda_layout_helper.dart';
import 'package:conferenceapp/agenda/widgets/talk_card.dart';
import 'package:conferenceapp/agenda/widgets/talk_hour.dart';
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
            padding: const EdgeInsets.only(
              left: 12.0,
              right: 12.0,
              top: 16.0,
              bottom: 62.0,
            ),
            physics:
                const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            itemCount: snapshot.length,
            itemBuilder: (context, index) {
              Talk? firstTalk;
              Talk? secondTalk;

              final thisHoursTalks = snapshot[index];

              firstTalk = thisHoursTalks.data;
              secondTalk = thisHoursTalks.data;

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
            itemCount: snapshot.length,
            itemBuilder: (context, index) {
              Talk? firstTalk;
              Talk? secondTalk;

              final thisHoursTalks = snapshot[index];

              if (thisHoursTalks.data.type == TalkType.beginner) {
                firstTalk = thisHoursTalks.data;
              } else {
                secondTalk = thisHoursTalks.data;
              }
              // _firstTalk = _thisHoursTalks.data;
              // .firstWhere(
              //   (t) => t.room.id != TalkType.advanced.toString(),
              // );
              // _secondTalk = _thisHoursTalks.data;
              // .firstWhere(
              //   (t) => t.room.id == TalkType.advanced.toString(),
              // );

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

  Column getNormalTalkCards(Talk? firstTalk, List<String> favoriteTalks,
      BuildContext context, Talk? secondTalk) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (firstTalk != null)
          TalkCard(
            key: ValueKey(firstTalk.id),
            talk: firstTalk,
            isFavorite: favoriteTalks.contains(firstTalk.id),
            first: true,
            compact: false,
            onTap: () => onTap(context, firstTalk),
          ),
        if (secondTalk != null)
          TalkCard(
            key: ValueKey(secondTalk.id),
            talk: secondTalk,
            isFavorite: favoriteTalks.contains(secondTalk.id),
            first: false,
            compact: false,
            onTap: () => onTap(context, secondTalk),
          ),
      ],
    );
  }

  Row getCompactTalkCards(Talk firstTalk, Talk secondTalk,
      List<String> favoriteTalks, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CompactLeftTalkContainer(talk: firstTalk),
        if (firstTalk.type == TalkType.other)
          Expanded(
            child: TalkCard(
              key: ValueKey(firstTalk.id),
              talk: firstTalk,
              isFavorite: favoriteTalks.contains(firstTalk.id),
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
              isFavorite: favoriteTalks.contains(firstTalk.id),
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
              isFavorite: favoriteTalks.contains(firstTalk.id),
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
