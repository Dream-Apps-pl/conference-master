import 'package:conferenceapp/generated/l10n.dart';
import 'package:flutter/material.dart';

class ScanYourTicketPlaceholder extends StatelessWidget {
  const ScanYourTicketPlaceholder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Image.asset(
            'assets/ticket_empty.png',
            height: 220,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            S.current.addTicketNumber,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey[700]
                  : Colors.grey[200],
            ),
          ),
        )
      ],
    );
  }
}
