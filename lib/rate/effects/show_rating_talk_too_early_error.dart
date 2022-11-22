import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showRatingTalkTooEarlyError(BuildContext context) {
  final config = Provider.of<RemoteConfigSettings>(context, listen: false);
  final minutes = config.minimumFetchInterval;

  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
          "Talk can be rated $minutes minutes before the presentation is finished."),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Theme.of(context).primaryColor,
    ),
  );
}
