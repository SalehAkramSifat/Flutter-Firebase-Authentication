import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

class AuthSetup {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationId = "";

  // For Create Account By Mobile Number with OTP ==========================================
  Future<void> verifyPhoneNumber(String phoneNumber, Function(String) codeSentCallback) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          log("Phone number automatically verified and signed in.");
        },
        verificationFailed: (FirebaseAuthException e) {
          log("Phone verification failed: ${e.message}");
        },
        codeSent: (String verificationId, int? resendToken) {
          this.verificationId = verificationId;
          codeSentCallback(verificationId);
          log("OTP sent to $phoneNumber");
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId = verificationId;
        },
      );
    } catch (e) {
      log("Phone verification error: $e");
    }
  }

  // For Sign In with Phone OTP ==========================================
  Future<User?> signInWithOTP(String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      UserCredential userCredential = await _auth.signInWithCredential(credential);
      log("Phone number signed in successfully.");
      return userCredential.user;
    } catch (e) {
      log("OTP Sign-in error: $e");
      return null;
    }
  }

  // For Create Account By Email and Password ==========================================
  Future<User?> createUserWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await sendEmailVerification();
      return cred.user;
    } catch (e) {
      if (e is FirebaseAuthException) {
        log('Firebase Error: ${e.message}');
      } else {
        log('Unknown Error: $e');
      }
    }
    return null;
  }

  // For Login Account ==========================================
  Future<User?> loginUserWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (!(await isEmailVerified())) {
        log("Email not verified!");
        return null;
      }
      return cred.user;
    } catch (e) {
      if (e is FirebaseAuthException) {
        log('Firebase Error: ${e.message}');
      } else {
        log('Unknown Error: $e');
      }
    }
    return null;
  }

  // For Logout ==========================================
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log('Logout Error: $e');
    }
  }

  // For Sending Email Verification ==========================================
  Future<void> sendEmailVerification() async {
    try {
      User? user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        log("Verification email sent!");
      }
    } catch (e) {
      log("Email Verification Error: $e");
    }
  }

  // Check if Email is Verified ==========================================
  Future<bool> isEmailVerified() async {
    User? user = _auth.currentUser;
    if (user != null) {
      await user.reload();
      return user.emailVerified;
    }
    return false;
  }
}
