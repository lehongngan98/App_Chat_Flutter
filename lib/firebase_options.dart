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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDz6yS6PMjiDE6-oBBjkgEQ2_p63906ES8',
    appId: '1:301103447500:android:5d24d8f829be88fbf13169',
    messagingSenderId: '301103447500',
    projectId: 'app-chat-b738e',
    storageBucket: 'app-chat-b738e.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBfGoioYkU-h_-dfJL_ypt0bem5Vr2oQyo',
    appId: '1:301103447500:ios:c764633047fc1bc0f13169',
    messagingSenderId: '301103447500',
    projectId: 'app-chat-b738e',
    storageBucket: 'app-chat-b738e.firebasestorage.app',
    androidClientId: '301103447500-3uv5h570nt0gtmp8vn4muqsrcgq1r1lm.apps.googleusercontent.com',
    iosClientId: '301103447500-tkcdh81a19hdef9ues1qf718l9v3ui6q.apps.googleusercontent.com',
    iosBundleId: 'com.example.appChat',
  );

}