import 'package:conferenceapp/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class SaveTicketButton extends StatelessWidget {
  const SaveTicketButton({
    Key? key,
    required this.enabled,
    required this.onSave,
  }) : super(key: key);

  final bool enabled;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            S.current.save,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          SizedBox(width: 6),
          Icon(
            LineIcons.checkCircle,
            color: Colors.white,
          )
        ],
      ),
      onPressed: enabled ? onSave : null,
    );
  }
}
