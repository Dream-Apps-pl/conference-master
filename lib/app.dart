import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conferenceapp/agenda/bloc/bloc.dart';
import 'package:conferenceapp/agenda/helpers/agenda_layout_helper.dart';
import 'package:conferenceapp/agenda/repository/contentful_talks_repository.dart';
import 'package:conferenceapp/agenda/repository/file_storage.dart';
import 'package:conferenceapp/agenda/repository/firestore_talks_repository.dart';
import 'package:conferenceapp/agenda/repository/reactive_talks_repository.dart';
import 'package:conferenceapp/agenda/repository/talks_repository.dart';
import 'package:conferenceapp/common/logger.dart';
import 'package:conferenceapp/main_page/home_page.dart';
import 'package:conferenceapp/notifications/repository/notifications_repository.dart';
import 'package:conferenceapp/notifications/repository/notifications_unread_repository.dart';
import 'package:conferenceapp/organizers/organizers_repository.dart';
import 'package:conferenceapp/profile/auth_repository.dart';
import 'package:conferenceapp/profile/favorites_repository.dart';
import 'package:conferenceapp/profile/user_repository.dart';
import 'package:conferenceapp/rate/repository/firestore_ratings_repository.dart';
import 'package:conferenceapp/rate/repository/ratings_repository.dart';
import 'package:conferenceapp/sponsors/sponsors_repository.dart';
import 'package:conferenceapp/talk/talk_page.dart';
import 'package:conferenceapp/ticket/bloc/bloc.dart';
import 'package:conferenceapp/ticket/repository/ticket_repository.dart';
import 'package:conferenceapp/utils/color.dart';
import 'package:conferenceapp/utils/contentful_client.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config.dart';
import 'utils/analytics.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.title,
    required this.sharedPreferences,
    required this.firebaseMessaging,
  }) : super(key: key);

  final String title;
  final SharedPreferences sharedPreferences;
  final FirebaseMessaging firebaseMessaging;

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      themeCollection: themeCollection,
      // data: (brightness) => ThemeData(
      //   primaryColor: blue,
      //   scaffoldBackgroundColor: brightness == Brightness.light
      //       ? Colors.grey[100]
      //       : Colors.grey[850],
      //   accentColor: orange,
      //   toggleableActiveColor: orange,
      //   dividerColor:
      //       brightness == Brightness.light ? Colors.white : Colors.white54,
      //   brightness: brightness,
      //   fontFamily: 'PTSans',
      //   bottomAppBarTheme: Theme.of(context).bottomAppBarTheme.copyWith(
      //         elevation: 0,
      //       ),
      //   // pageTransitionsTheme: PageTransitionsTheme(
      //   //   builders: <TargetPlatform, PageTransitionsBuilder>{
      //   //     TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      //   //     TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      //   //   },
      //   // ),
      //   iconTheme: Theme.of(context).iconTheme.copyWith(color: orange),
      // ),
      builder: (context, theme) {
        return VariousProviders(
          sharedPreferences: sharedPreferences,
          firebaseMessaging: firebaseMessaging,
          child: RepositoryProviders(
            child: BlocProviders(
              child: ChangeNotifierProviders(
                child: FeatureDiscovery(
                  child: MaterialApp(
                      debugShowCheckedModeBanner: false,
                      title: title,
                      theme: theme,
                      navigatorKey: navigatorKey,
                      navigatorObservers: [
                        FirebaseAnalyticsObserver(analytics: analytics!),
                      ],
                      home: HomePage(title: title)),
                  // child: Snapfeed(
                  //   projectId: appConfig.snapfeedProjectId,
                  //   secret: appConfig.snapfeedSecret,
                  //   config: SnapfeedConfig.defaultConfig(
                  //     teaserMessage:
                  //         'Start feedback and navigate to the page you want to ',
                  //     feedbackMessage:
                  //         'Write down what\'s on your mind. You can also navigate and draw on the screen for better context. Thanks for helping us out!',
                  //   ),
                  //   child: MaterialApp(
                  //       debugShowCheckedModeBanner: false,
                  //       title: title,
                  //       theme: theme,
                  //       navigatorKey: navigatorKey,
                  //       navigatorObservers: [
                  //         FirebaseAnalyticsObserver(analytics: analytics),
                  //       ],
                  //       home: HomePage(title: title)),
                  // ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

final navigatorKey = GlobalKey<NavigatorState>();

class VariousProviders extends StatefulWidget {
  final Widget child;
  final SharedPreferences sharedPreferences;
  final FirebaseMessaging firebaseMessaging;

  const VariousProviders({
    Key? key,
    required this.child,
    required this.sharedPreferences,
    required this.firebaseMessaging,
  }) : super(key: key);

  @override
  _VariousProvidersState createState() => _VariousProvidersState();
}

class _VariousProvidersState extends State<VariousProviders> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late ContentfulClient contentfulClient;

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    contentfulClient = ContentfulClient(
      appConfig!.contentfulSpace,
      appConfig!.contentfulApiKey,
    );

    initializeRemoteNotifications();
    initializeLocalNotifications();
  }

  Future<FirebaseRemoteConfig> initializeRemoteConfig() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.fetch();
    await remoteConfig.fetchAndActivate();
    final _ = remoteConfig.getAll();
    final shared = await SharedPreferences.getInstance();
    shared.setInt('cache_duration', remoteConfig.getInt('cache_duration'));

    return remoteConfig;
  }

  void initializeLocalNotifications() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    final initializationSettingsIOS = DarwinInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void initializeRemoteNotifications() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    widget.firebaseMessaging.subscribeToTopic('notifications');
    final reminders = widget.sharedPreferences.getBool('reminders');
    if (reminders == null) {
      widget.sharedPreferences.setBool('reminders', true);
    }
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    logger.info(id.toString());
    logger.info(title!);
    logger.info(body!);
    logger.info(payload!);
    return Future.value(true);
  }

  Future onSelectNotification(String payload) async {
    logger.info('notification payload: ' + payload);

    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (context) => TalkPage(payload),
        settings: RouteSettings(name: 'agenda/$payload'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SharedPreferences>.value(
          value: widget.sharedPreferences,
        ),
        Provider<FirebaseMessaging>.value(
          value: widget.firebaseMessaging,
        ),
        Provider<FlutterLocalNotificationsPlugin>.value(
          value: flutterLocalNotificationsPlugin,
        ),
        Provider<ContentfulClient>.value(
          value: contentfulClient,
        ),
        FutureProvider<FirebaseRemoteConfig>(
          create: (_) async => initializeRemoteConfig(),
          initialData: FirebaseRemoteConfig.instance,
          lazy: false,
        ),
      ],
      child: widget.child,
    );
  }
}

class BlocProviders extends StatelessWidget {
  const BlocProviders({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AgendaBloc>(
          create: (BuildContext context) =>
              AgendaBloc(RepositoryProvider.of<TalkRepository>(context))
                ..add(InitAgenda()),
        ),
        BlocProvider<TicketBloc>(
          create: (BuildContext context) => TicketBloc(
            RepositoryProvider.of<TicketRepository>(context),
            RepositoryProvider.of<UserRepository>(context),
          ),
          // )..add(FetchTicket()),
        ),
      ],
      child: child,
    );
  }
}

class RepositoryProviders extends StatelessWidget {
  final Widget child;

  const RepositoryProviders({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sharedPreferences = Provider.of<SharedPreferences>(context);
    final client = Provider.of<ContentfulClient>(context);

    return RepositoryProvider(
      create: (_) =>
          AuthRepository(FirebaseAuth.instance, FirebaseFirestore.instance),
      child: RepositoryProvider(
        create: _userRepositoryBuilder,
        child: RepositoryProvider<TalkRepository>(
          create: (context) => _talksRepositoryBuilder(context, client),
          child: RepositoryProvider(
            create: _favoritesRepositoryBuilder,
            child: RepositoryProvider(
              create: (context) => _sponsorsRepositoryBuilder(context, client),
              child: RepositoryProvider(
                create: (context) =>
                    _organizersRepositoryBuilder(context, client),
                child: RepositoryProvider(
                  create: _ticketRepositoryBuilder,
                  child: RepositoryProvider(
                    create: _notificationsRepositoryBuilder,
                    child: RepositoryProvider(
                      create: (context) =>
                          _notificationsUnreadStatusRepositoryBuilder(
                              context, sharedPreferences),
                      child: RepositoryProvider<RatingsRepository>(
                        create: (context) => _ratingsRepositoryBuilder(context,
                            sharedPreferences, FirebaseFirestore.instance),
                        child: child,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  UserRepository _userRepositoryBuilder(BuildContext context) {
    return UserRepository(
      RepositoryProvider.of<AuthRepository>(context),
      FirebaseFirestore.instance,
    );
  }

  FavoritesRepository _favoritesRepositoryBuilder(BuildContext context) {
    return FavoritesRepository(
      RepositoryProvider.of<TalkRepository>(context),
      RepositoryProvider.of<UserRepository>(context),
    );
  }

  SponsorsRepository _sponsorsRepositoryBuilder(
      BuildContext context, ContentfulClient client) {
    return SponsorsRepository(
      client,
    );
  }

  OrganizersRepository _organizersRepositoryBuilder(
      BuildContext context, ContentfulClient client) {
    return OrganizersRepository(
      client,
    );
  }

  FirestoreNotificationsRepository _notificationsRepositoryBuilder(
      BuildContext context) {
    return FirestoreNotificationsRepository(FirebaseFirestore.instance);
  }

  AppNotificationsUnreadStatusRepository
      _notificationsUnreadStatusRepositoryBuilder(
          BuildContext context, SharedPreferences sharedPreferences) {
    return AppNotificationsUnreadStatusRepository(
      RepositoryProvider.of<FirestoreNotificationsRepository>(context),
      sharedPreferences,
    );
  }

  TicketRepository _ticketRepositoryBuilder(BuildContext context) {
    return TicketRepository(
      RepositoryProvider.of<UserRepository>(context),
    );
  }

  TalkRepository _talksRepositoryBuilder(
      BuildContext context, ContentfulClient client) {
    final sharedPrefs = Provider.of<SharedPreferences>(context, listen: false);
    final cache = sharedPrefs.getInt('cache_duration') ?? 90;
    return FirestoreTalkRepository();
    // return ReactiveTalksRepository(
    //   repository: ContentfulTalksRepository(
    //       client: client,
    //       fileStorage: FileStorage(
    //         'talks',
    //         () => Directory.systemTemp,
    //       ),
    //       cacheDuration: Duration(
    //         minutes: cache == 0 ? 90 : cache,
    //       )),
    // );
  }

  RatingsRepository _ratingsRepositoryBuilder(BuildContext context,
      SharedPreferences sharedPreferences, FirebaseFirestore firestore) {
    return FirestoreRatingsRepository(
        sharedPreferences,
        firestore.collection("ratings"),
        RepositoryProvider.of<UserRepository>(context));
  }
}

class ChangeNotifierProviders extends StatelessWidget {
  const ChangeNotifierProviders({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final sharedPreferences = Provider.of<SharedPreferences>(context);
    final agendaMode = sharedPreferences.getString('agenda_mode');
    final compactMode = agendaMode == 'compact' || agendaMode == null;

    return ChangeNotifierProvider<AgendaLayoutHelper>(
      create: (_) => AgendaLayoutHelper(compactMode),
      child: child,
    );
  }
}
