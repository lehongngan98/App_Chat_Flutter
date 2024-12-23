import 'package:app_chat/screens/auth/login_screen.dart';
import 'package:app_chat/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

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
        home: const LoginScreen());
  }
}
