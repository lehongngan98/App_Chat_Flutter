
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class APIs {
  // for Firebase Auth
  static FirebaseAuth auth = FirebaseAuth.instance;

  // for Firebase Firestore
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
}