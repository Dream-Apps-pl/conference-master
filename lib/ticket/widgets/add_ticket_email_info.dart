import 'package:conferenceapp/common/logger.dart';
import 'package:conferenceapp/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class AddTicketEmailInfo extends StatelessWidget {
  const AddTicketEmailInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: sendEmail,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          S.current.notifTicketEmail,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.grey[700]
                : Colors.grey[200],
          ),
        ),
      ),
    );
  }

  void sendEmail() async {
    final email = 'tickets@fluttereurope.dev';
    final subject = 'Problem with accessing ticket in mobile app';
    final body =
        'Hi! I have problem with adding ticket in my Flutter Europe conference app.';
    final url = Uri.encodeFull('mailto:$email?subject=$subject&body=$body');
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      logger.warn('Could not launch $url, trying typical share');
      Share.share(body, subject: body);
    }
  }
}
