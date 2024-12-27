import 'dart:developer';
import 'dart:io';

import 'package:app_chat/api/apis.dart';
import 'package:app_chat/main.dart';
import 'package:app_chat/helper/dialogs.dart';
import 'package:app_chat/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAnimate = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isAnimate = true;
      });
    });
  }

  // Handle Google button click
  _handleGoogleBtnClick() async {
    // Show progress bar
    Dialogs.showProgressBar(context);
    _signInWithGoogle().then((user) {
      // Hide progress bar
      Navigator.pop(context);
      if (user != null) {
        log('\nUser: ${user.user}');
        log('\nUserAdditionalInfo: ${user.additionalUserInfo}');

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    }).catchError((error) {
      print(error);
    });
  }

  // Sign in with Google
  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await APIs.auth.signInWithCredential(credential);
    } catch (error) {
      log('\n_signInWithGoogle : $error');
      Dialogs.showSnackbar(context, 'Something went wrong (check your internet connection)');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      // app bar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Welcome to App Chat'),
      ),

      body: Stack(children: [
        AnimatedPositioned(
            top: mq.height * .10,
            right: _isAnimate ? mq.width * .3 : -mq.width * .5,
            width: mq.width * .4,
            duration: const Duration(seconds: 1),
            child: Image.asset('images/chat.png')),
        Positioned(
            bottom: mq.height * .15,
            left: mq.width * .05,
            width: mq.width * .9,
            height: mq.height * .07,
            child: ElevatedButton.icon(
                onPressed: () {
                  _handleGoogleBtnClick();
                },
                label: RichText(
                    text: const TextSpan(
                        text: 'Sign in with Google',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold))),
                icon:
                    Image.asset('images/google.png', height: mq.height * .05)))
      ]),
    );
  }
}
