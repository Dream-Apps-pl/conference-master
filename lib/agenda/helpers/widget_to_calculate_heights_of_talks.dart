import 'package:collection/collection.dart';
import 'package:conferenceapp/agenda/helpers/agenda_layout_helper.dart';
import 'package:conferenceapp/agenda/widgets/talk_card.dart';
import 'package:conferenceapp/agenda/widgets/talk_hour.dart';
import 'package:conferenceapp/model/talk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// This is a hacky workaround to calculate sizes of talk containers
// before rendering them in the list view.
// Gathering dimensions of the talks cards allows us to
// animate their sizes and positions in Stacks.
// This widget shouldn't be displayed normally
// but instead rendered once to calculate all the dimensions.
class WidgetUsedToCalculateHeightsOfTalkCards extends StatefulWidget {
  const WidgetUsedToCalculateHeightsOfTalkCards({
    Key? key,
    required this.talks,
  }) : super(key: key);
  final Map<int, List<Talk>> talks;

  @override
  _WidgetUsedToCalculateHeightsOfTalkCardsState createState() =>
      _WidgetUsedToCalculateHeightsOfTalkCardsState();
}

class _WidgetUsedToCalculateHeightsOfTalkCardsState
    extends State<WidgetUsedToCalculateHeightsOfTalkCards> {
  @override
  Widget build(BuildContext context) {
    final layoutHelper = Provider.of<AgendaLayoutHelper>(context);

    if (widget.talks.isEmpty) {
      return Container();
    }

    final talksPerHour = groupBy<Talk, DateTime>(
        [...widget.talks[0]!, ...widget.talks[1]!], (t) => t.startTime);

    layoutHelper
        .setTalksCount(widget.talks[0]!.length + widget.talks[1]!.length);
    final hours = talksPerHour.keys.toList();

    final widgets = <Widget>[];
    for (var index = 0; index < talksPerHour.length; index++) {
      final thisHoursTalks = talksPerHour[hours[index]];
      final talk = thisHoursTalks?.firstWhere(
        (t) => t.room.id != TalkType.advanced.toString(),
      );
      final nextTalk = thisHoursTalks?.firstWhere(
        (t) => t.room.id == TalkType.advanced.toString(),
      );

      widgets.add(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Opacity(
                  opacity: 0.0,
                  child: CompactLeftTalkContainer(
                    talk: talk ?? nextTalk!,
                  ),
                ),
                if (talk != null)
                  Flexible(
                    child: CompactPlaceholderTalkCard(
                      talk: talk,
                      compact: true,
                      helper: layoutHelper,
                    ),
                  )
                else
                  Flexible(child: Container()),
                const SizedBox(width: 10),
                if (nextTalk != null)
                  Flexible(
                    child: CompactPlaceholderTalkCard(
                      talk: nextTalk,
                      compact: true,
                      helper: layoutHelper,
                    ),
                  )
                else
                  Flexible(child: Container()),
              ],
            ),
          ],
        ),
      );
      widgets.add(
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            NormalPlaceholderTalkCard(
              talk: talk!,
              compact: false,
              first: true,
              helper: layoutHelper,
            ),
            if (nextTalk != null)
              NormalPlaceholderTalkCard(
                talk: nextTalk,
                compact: false,
                first: false,
                helper: layoutHelper,
              )
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 16.0,
      ),
      child: Stack(
        children: widgets,
      ),
    );
  }
}

class CompactPlaceholderTalkCard extends StatelessWidget {
  CompactPlaceholderTalkCard({
    Key? key,
    required this.talk,
    required this.compact,
    required this.helper,
  }) : super(key: key);

  final Talk talk;
  final bool compact;
  final GlobalKey _keyRed = GlobalKey();
  final AgendaLayoutHelper helper;

  _getSize() {
    try {
      final RenderBox renderBoxRed =
          _keyRed.currentContext!.findRenderObject() as RenderBox;
      final sizeRed = renderBoxRed.size;

      helper.setCompactTalkHeight(talk.id, sizeRed.height);
    } catch (e) {
      //ignore
    }
  }

  _afterLayout(_) {
    _getSize();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);

    return Opacity(
      key: _keyRed,
      opacity: 0.0,
      child: Container(
        color: Colors.red,
        child: TalkCard(
          talk: talk,
          isFavorite: false,
          first: false,
          compact: compact, onTap: () {  },
        ),
      ),
    );
  }
}

class NormalPlaceholderTalkCard extends StatelessWidget {
  NormalPlaceholderTalkCard({
    Key? key,
    required this.talk,
    required this.compact,
    required this.first,
    required this.helper,
  }) : super(key: key);

  final Talk talk;
  final bool compact;
  final bool first;
  final GlobalKey _keyRed = GlobalKey();
  final AgendaLayoutHelper helper;

  _getSize() {
    try {
      final RenderBox renderBoxRed = _keyRed.currentContext!.findRenderObject() as RenderBox;
      final sizeRed = renderBoxRed.size;

      helper.setNormalTalkHeight(talk.id, sizeRed.height);
    } catch (e) {
      //ignore
    }
  }

  _afterLayout(_) {
    _getSize();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);

    return Opacity(
      key: _keyRed,
      opacity: 0.0,
      child: Container(
        color: Colors.red,
        child: TalkCard(
          talk: talk,
          isFavorite: false,
          first: first,
          compact: compact, onTap: () {  },
        ),
      ),
    );
  }
}
