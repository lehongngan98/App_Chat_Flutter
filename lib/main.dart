import 'package:app_chat/screens/auth/login_screen.dart';
import 'package:app_chat/screens/home_screen.dart';
import 'package:app_chat/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';

void main() {
  // Ensure that Firebase is initialized
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter bindings are initialized

  // hide the status bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

// for setting the orientation to portrait only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) {
    // initialize firebase
    _initFirebase();
    // run the app
    runApp(const MyApp());
  });
}

// global object the screen size
late Size mq;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'App Chat',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
              centerTitle: true,
              iconTheme: const IconThemeData(color: Colors.black),
              elevation: 1,
              titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                  color: Colors.black)),
        ),
        home: const SplashScreen());
  }
}

_initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
