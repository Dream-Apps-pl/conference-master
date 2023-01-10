import 'package:conferenceapp/generated/l10n.dart';
import 'package:flutter/material.dart';

class TicketPageTitle extends StatelessWidget {
  const TicketPageTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        S.current.yourTicket,
        style: TextStyle(
          fontSize: 22,
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Colors.grey[200],
        ),
      ),
    );
  }
}
