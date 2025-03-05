import 'dart:developer';  // লগিং এর জন্য সঠিক লাইব্রেরি ইম্পোর্ট করুন

import 'package:firebase_auth/firebase_auth.dart';

class AuthSetup {
  final _auth = FirebaseAuth.instance;

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return cred.user;
    } catch (e) {
      log("Something went wrong");  // সঠিক লগ স্টেটমেন্ট
    }
    return null;
  }

  Future<User?> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return cred.user;
    } catch (e) {
      log("Something went wrong");  // সঠিক লগ স্টেটমেন্ট
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("Something went wrong");  // সঠিক লগ স্টেটমেন্ট
    }
  }
}
