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
      log('User created: ${cred.user}');
      log('User UID: ${cred.user?.uid}');
      log('User email: ${cred.user?.email}');
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

  Future<String?> getIdToken() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final token = await user.getIdToken();
        log('Token: $token');
        return token;
      } else {
        log('User is not signed in');
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  bool isUserLoggedIn() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        log('User is logged in');
        return true;
      } else {
        log('User is not logged in');
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  String getUserUid() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        log('User UID: ${user.uid}');
        return user.uid;
      } else {
        log('User is not logged in');
        return "-1";
      }
    } catch (e) {
      print(e.toString());
    }
    return "-1";
  }
}
