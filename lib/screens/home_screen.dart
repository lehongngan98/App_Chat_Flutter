import 'dart:convert';
import 'dart:developer';

import 'package:app_chat/api/apis.dart';
import 'package:app_chat/models/chat_user.dart';
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
  List<ChatUser> list = [];

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
          switch (snapshot.connectionState) {
            // data is loading
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(child: CircularProgressIndicator());

            // if some or all data is loaded then show it
            case ConnectionState.active:
            case ConnectionState.done:              
              final data = snapshot.data?.docs;
              // convert data to list of ChatUser
              list = data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
              // check if list is not empty
              if (list.isNotEmpty) {
                return ListView.builder(
                  itemCount: list.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ChatUserCard(user: list[index]);
                  },
                );
              } else {
                return const Center(child: Text('No user found', style: TextStyle(fontSize: 20)));
              }
          }
        },
      ),
    );
  }
}
