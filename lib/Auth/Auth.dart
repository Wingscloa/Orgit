import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential?> loginWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      final googleAuth = await googleUser?.authentication;

      final cred = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);

      return await _auth.signInWithCredential(cred);
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      log('CreateUserWithEmailAndPassword went wrong');
    }
    return null;
  }

  Future<User?> logInUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      log('signInWithEmailAndPassword went wrong');
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log('signOut went wrong');
      print(e.toString());
    }
  }

  Future<void> changePassword(String email) async {
    try {
      if (_auth.isSignInWithEmailLink(email)) {
        log('Email existuje');
        await _auth.sendPasswordResetEmail(email: email.trim());
      } else {
        log('Email neexistuje');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
