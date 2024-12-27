import 'dart:developer';

import 'package:app_chat/api/apis.dart';
import 'package:app_chat/screens/auth/login_screen.dart';
import 'package:app_chat/widgets/chat_user_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Logout function
  Future<void> _logout() async {
    await APIs.auth.signOut();
    await GoogleSignIn().signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // app bar
      appBar: AppBar(
        leading: const Icon(CupertinoIcons.home),
        title: const Text('App Chat'),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),

      // Floating action button to add new user
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
            onPressed: () async {
              await APIs.auth.signOut();
              await GoogleSignIn().signOut();
            },
            child: Icon(Icons.add_comment_rounded)),
      ),

      // Body
      // body: Center(
      //   child: ElevatedButton.icon(
      //     onPressed: _logout, // Call the logout function
      //     icon: const Icon(Icons.logout),
      //     label: const Text('Logout'),
      //     style: ElevatedButton.styleFrom(
      //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      //       textStyle: const TextStyle(fontSize: 16),
      //     ),
      //   ),
      // ),

      body: StreamBuilder(
        // 
        stream: APIs.firestore.collection('users').snapshots(),
        builder: (context, snapshot) {
          final list = [];

          if(snapshot.hasData){
            final data = snapshot.data?.docs;
            for (var item in data!) {
              log('Data: ${item.data()}');
              list.add(item.data()['name']);
            }
          }
          return ListView.builder(
            itemCount: list.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              // return const ChatUserCard();
              return Text('User: ${list[index]}');
            },
          );
        },
      ),
    );
  }
}
