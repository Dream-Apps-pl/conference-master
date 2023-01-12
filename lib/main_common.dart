import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:conferenceapp/common/logger.dart';
import 'package:conferenceapp/config.dart';
import 'package:conferenceapp/firebase_options.dart';
import 'package:conferenceapp/utils/analytics.dart';
import 'package:conferenceapp/utils/bloc_delegate.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';

void mainCommon({required AppConfig config}) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = SimpleBlocObserver();
  FlutterError.onError = (error) {
    logger.error(error.exceptionAsString());
    // FirebaseCrashlytics.instance.recordFlutterError(error);
  };

  runZoned<Future<void>>(
    () async {
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
    },
  );
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('center'),
      ),
    );
  }
}

class MyAppWidget extends StatelessWidget {
  const MyAppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yuk Mewarnai',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyWidget(),
    );
  }
}
