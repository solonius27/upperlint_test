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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCQZACmFcmPNvZJfS_au2dVXIa6L-82N50',
    appId: '1:58162900702:web:ce3ef8e72faf491046dc4f',
    messagingSenderId: '58162900702',
    projectId: 'upperlink-test-proj',
    authDomain: 'upperlink-test-proj.firebaseapp.com',
    databaseURL: 'https://upperlink-test-proj-default-rtdb.firebaseio.com',
    storageBucket: 'upperlink-test-proj.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBGdtaTHjCc0uIS_Nz6yBcQUtw_W5Yrpk0',
    appId: '1:58162900702:android:9e0771cb5373729f46dc4f',
    messagingSenderId: '58162900702',
    projectId: 'upperlink-test-proj',
    databaseURL: 'https://upperlink-test-proj-default-rtdb.firebaseio.com',
    storageBucket: 'upperlink-test-proj.appspot.com',
  );
}