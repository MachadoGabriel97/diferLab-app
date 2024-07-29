// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyByW6xAY0wD4dJDe701bMPQoPNZGnVc0e8',
    appId: '1:689521290036:web:36bf3147d1f9b00b641361',
    messagingSenderId: '689521290036',
    projectId: 'diferlab-7aa9f',
    authDomain: 'diferlab-7aa9f.firebaseapp.com',
    storageBucket: 'diferlab-7aa9f.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCw10NcUTWn_Ymt9UiUKN0XCSUigDzYjaM',
    appId: '1:689521290036:android:b719f35c7c72f45f641361',
    messagingSenderId: '689521290036',
    projectId: 'diferlab-7aa9f',
    storageBucket: 'diferlab-7aa9f.appspot.com',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyByW6xAY0wD4dJDe701bMPQoPNZGnVc0e8',
    appId: '1:689521290036:web:320a9616f1dd0925641361',
    messagingSenderId: '689521290036',
    projectId: 'diferlab-7aa9f',
    authDomain: 'diferlab-7aa9f.firebaseapp.com',
    storageBucket: 'diferlab-7aa9f.appspot.com',
  );
}