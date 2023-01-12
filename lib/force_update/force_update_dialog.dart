import 'dart:io';
import 'package:conferenceapp/force_update/store_urls.dart';
import 'package:conferenceapp/generated/l10n.dart';
import 'package:conferenceapp/utils/url_launcher.dart';
import 'package:flutter/material.dart';

showForceUpdateDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return const _ForceUpdateDialog();
    },
  );
}

class _ForceUpdateDialog extends StatelessWidget {
  const _ForceUpdateDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(S.current.outdatedTitle),
      contentPadding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
      children: <Widget>[
        Text(S.current.outdatedSubtitle),
        const SizedBox(
          height: 16,
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: TextButton(
            child: Text(S.current.update),
            onPressed: () {
              final url =
                  Platform.isAndroid ? StoreUrls.android : StoreUrls.iOS;

              UrlLauncher.launch(url);
            },
          ),
        ),
      ],
    );
  }
}
