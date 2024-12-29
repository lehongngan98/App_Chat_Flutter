import 'dart:developer';

import 'package:app_chat/models/chat_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class APIs {
  // for Firebase Auth
  static FirebaseAuth auth = FirebaseAuth.instance;

  // for Firebase Firestore
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // for storing self information
  static late ChatUser me;

  // to return current user
  static User get user => auth.currentUser!;

  // for checking if user exists or not?
  static Future<bool> userExist() async {
    // if user exists then return true else false
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  // for getting current user information
  static Future<void> getSelfInfo() async {
    await firestore.collection('users').doc(user.uid).get().then((user) async {
      if (user.exists) {
        me = ChatUser.fromJson(user.data()!);
        log('My data : ${user.data()}');
      } else {
        await createUser().then((value) => getSelfInfo());
      }
    });
  }

  // for creating a new user
  static Future<void> createUser() async {
    final time = DateTime.now().microsecondsSinceEpoch.toString();

    final chatUser = ChatUser(
      id: user.uid,
      email: user.email,
      name: user.displayName.toString(),
      image: user.photoURL.toString(),
      about: 'Hey there! I am using Chat App.',
      createdAt: time,
      isOnline: false,
      lastActive: time,
      pushToken: '',
    );

    // create a new user in Firestore
    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson());
  }

  // get all user from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUser() {
    return APIs.firestore
        .collection('users')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }

  // for update user information
  static Future<void> updateUserInfo() async {
    try {
      await firestore.collection('users').doc(user.uid).update({
        'name': me.name,
        'about': me.about,
      });
      log('User info updated successfully');
    } catch (e) {
      log('Error updating user info: $e');
    }
  }
}
