import 'package:app_chat/models/chat_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class APIs {
  // for Firebase Auth
  static FirebaseAuth auth = FirebaseAuth.instance;

  // for Firebase Firestore
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // to return curent user
  static User get user => auth.currentUser!;

  // for checking if user exists or not?
  static Future<bool> userExist() async {
    // if user exists then return true else false
    return (await firestore.collection('users').doc(user.uid).get()).exists;
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
}
