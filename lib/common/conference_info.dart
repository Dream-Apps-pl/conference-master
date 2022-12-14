import 'package:conferenceapp/generated/l10n.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class ConferenceInfo extends StatelessWidget {
  const ConferenceInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: DottedBorder(
        borderType: BorderType.Rect,
        dashPattern: const [4, 4],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${S.current.venue}:',
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      S.current.conferenceCenter,
                      textAlign: TextAlign.left,
                      softWrap: true,
                      maxLines: 2,
                    ),
                    Text(
                      S.current.scienceCenter,
                      textAlign: TextAlign.left,
                      softWrap: true,
                      maxLines: 2,
                    ),
                    Text(
                      S.current.wybrzeze,
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      S.current.warsaw,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: const Icon(LineIcons.mapSigns),
              onPressed: () async {
                if (await canLaunchUrl(
                    Uri.parse('https://goo.gl/maps/ChCCX5G71E5VRmWX6'))) {
                  launchUrl(Uri.parse('https://goo.gl/maps/ChCCX5G71E5VRmWX6'));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
