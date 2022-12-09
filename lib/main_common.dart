import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:conferenceapp/common/logger.dart';
import 'package:conferenceapp/config.dart';
import 'package:conferenceapp/utils/bloc_delegate.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bugfender/flutter_bugfender.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'app.dart';
import 'utils/analytics.dart';

void mainCommon({required AppConfig config}) {
  Bloc.observer = SimpleBlocObserver();
  FlutterError.onError = (error) {
    logger.error(error.exceptionAsString());
    // FirebaseCrashlytics.instance.recordFlutterError(error);
  };

  runZoned<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    analytics = FirebaseAnalytics.instance;
    appConfig = config;
    final sharedPrefs = await SharedPreferences.getInstance();
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    // FlutterBugfender.init(appConfig!.bugfenderKey!);

    runApp(
      MyApp(
        title: "Konferencje Sny i Wizje",
        sharedPreferences: sharedPrefs,
        firebaseMessaging: firebaseMessaging,
      ),
    );
  }, onError: (error, stack) {
    logger.errorException(error, stack);
    // return FirebaseCrashlytics.instance.recordError(error, stack);
  });
}
