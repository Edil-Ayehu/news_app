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
        return ios;
      case TargetPlatform.macOS:
        return macos;
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
    apiKey: 'AIzaSyCC__u6zoekyYi1Qn8HsHzFUURb4X9SDJo',
    appId: '1:1072379555648:web:441828c32330e81660d4a5',
    messagingSenderId: '1072379555648',
    projectId: 'news-app-95519',
    authDomain: 'news-app-95519.firebaseapp.com',
    storageBucket: 'news-app-95519.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBMSP-YQ0u_Y1fCop-0yj5rEGcoeG3v0gU',
    appId: '1:1072379555648:android:6e5f92c4cb8164d960d4a5',
    messagingSenderId: '1072379555648',
    projectId: 'news-app-95519',
    storageBucket: 'news-app-95519.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAmEU3qqho52L-iZrlyGOPl4BBpg4TOUqs',
    appId: '1:1072379555648:ios:1c0d8e3326f8c45760d4a5',
    messagingSenderId: '1072379555648',
    projectId: 'news-app-95519',
    storageBucket: 'news-app-95519.firebasestorage.app',
    iosBundleId: 'com.example.newsApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAmEU3qqho52L-iZrlyGOPl4BBpg4TOUqs',
    appId: '1:1072379555648:ios:1c0d8e3326f8c45760d4a5',
    messagingSenderId: '1072379555648',
    projectId: 'news-app-95519',
    storageBucket: 'news-app-95519.firebasestorage.app',
    iosBundleId: 'com.example.newsApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCC__u6zoekyYi1Qn8HsHzFUURb4X9SDJo',
    appId: '1:1072379555648:web:805c74bd9a18c73260d4a5',
    messagingSenderId: '1072379555648',
    projectId: 'news-app-95519',
    authDomain: 'news-app-95519.firebaseapp.com',
    storageBucket: 'news-app-95519.firebasestorage.app',
  );
}