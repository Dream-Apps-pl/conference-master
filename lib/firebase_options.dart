// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyATTrosbL0R5cS52KgmIlkGkgd_t2RI3Zc',
    appId: '1:181287176766:web:1a0fb075efbe8f50691f6f',
    messagingSenderId: '181287176766',
    projectId: 'comdreamappswydarzeniasiw',
    authDomain: 'comdreamappswydarzeniasiw.firebaseapp.com',
    storageBucket: 'comdreamappswydarzeniasiw.appspot.com',
    measurementId: 'G-E98S4R0FTG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCdBq9yKm6Mp5FTdjCC855h81bsTjAcaCo',
    appId: '1:181287176766:android:e852329fb04acdf7691f6f',
    messagingSenderId: '181287176766',
    projectId: 'comdreamappswydarzeniasiw',
    storageBucket: 'comdreamappswydarzeniasiw.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCNcfB9zvVd77TJIuswzhx4Y7pV2PyuuYk',
    appId: '1:181287176766:ios:4a677955381f8ecf691f6f',
    messagingSenderId: '181287176766',
    projectId: 'comdreamappswydarzeniasiw',
    storageBucket: 'comdreamappswydarzeniasiw.appspot.com',
    iosClientId: '181287176766-q17e8n7a9cl2eltdi5uodm7ch1a1td7b.apps.googleusercontent.com',
    iosBundleId: 'com.dreamapps.wydsnyiwizje',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCNcfB9zvVd77TJIuswzhx4Y7pV2PyuuYk',
    appId: '1:181287176766:ios:41a503872aeff41d691f6f',
    messagingSenderId: '181287176766',
    projectId: 'comdreamappswydarzeniasiw',
    storageBucket: 'comdreamappswydarzeniasiw.appspot.com',
    iosClientId: '181287176766-7ktq7jgv9rkpok3iciq4vg2agsnpn9ft.apps.googleusercontent.com',
    iosBundleId: 'com.dreamapps.wydarzeniasnyiwizje.conferenceapp',
  );
}
