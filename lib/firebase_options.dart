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
    apiKey: 'AIzaSyBUWSQH-kbBrTnkWAUlSlRElTs9DsgXQSg',
    appId: '1:784276635599:web:aa5b82942eeb5f61f89cba',
    messagingSenderId: '784276635599',
    projectId: 'nymble-s-app',
    authDomain: 'nymble-s-app.firebaseapp.com',
    storageBucket: 'nymble-s-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBoZzzbWiKdEml1oAwO0Ne9kUCqTm-ONJ8',
    appId: '1:784276635599:android:576975190ef7e07cf89cba',
    messagingSenderId: '784276635599',
    projectId: 'nymble-s-app',
    storageBucket: 'nymble-s-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBagydnM8gm8w2xQEGyHQlREOEX3oK9fIY',
    appId: '1:784276635599:ios:9f3b72c1ad690f3ff89cba',
    messagingSenderId: '784276635599',
    projectId: 'nymble-s-app',
    storageBucket: 'nymble-s-app.appspot.com',
    iosClientId: '784276635599-jkfouchj0pbaj4l6f97gabkt1maoo27o.apps.googleusercontent.com',
    iosBundleId: 'app.eatwithnymble.com.nymbleApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBagydnM8gm8w2xQEGyHQlREOEX3oK9fIY',
    appId: '1:784276635599:ios:9f3b72c1ad690f3ff89cba',
    messagingSenderId: '784276635599',
    projectId: 'nymble-s-app',
    storageBucket: 'nymble-s-app.appspot.com',
    iosClientId: '784276635599-jkfouchj0pbaj4l6f97gabkt1maoo27o.apps.googleusercontent.com',
    iosBundleId: 'app.eatwithnymble.com.nymbleApp',
  );
}