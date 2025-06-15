import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:orgit/services/api/api_client.dart';
import 'package:orgit/services/cache/cache.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _cacheService = CacheService.instance;

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (cred.user != null) {
        await _cacheService.setUserInfo(
          isLoggedIn: true,
          uid: cred.user!.uid,
          email: cred.user!.email,
        );
      }
      return cred.user;
    } on FirebaseAuthException catch (e) {
      log('CreateUserWithEmailAndPassword error: ${e.code}');
      String errorMessage = 'Chyba při registraci uživatele';

      if (e.code == 'email-already-in-use') {
        errorMessage = 'Tento email je již používán jiným účtem.';
      } else if (e.code == 'weak-password') {
        errorMessage = 'Heslo je příliš slabé.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Email není platný.';
      } else if (e.code == 'operation-not-allowed') {
        errorMessage = 'Registrace emailem a heslem není povolena.';
      }

      throw Exception(errorMessage);
    } catch (e) {
      log('CreateUserWithEmailAndPassword error: $e');
      throw Exception(
          'Došlo k neočekávané chybě při registraci. Zkuste to prosím znovu.');
    }
  }

  Future<UserCredential?> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        log('Google Sign In cancelled by user');
        throw Exception('Google přihlášení bylo zrušeno.');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      log('Google Sign In successful: ${userCredential.user?.email}');

      // Aktualizuj cache po úspěšném přihlášení
      if (userCredential.user != null) {
        await _cacheService.setUserInfo(
          isLoggedIn: true,
          uid: userCredential.user!.uid,
          email: userCredential.user!.email,
        );
      }
      return userCredential;
    } on FirebaseAuthException catch (e) {
      log('Google Sign In Firebase Auth error: ${e.code}');
      String errorMessage = 'Chyba při přihlášení pomocí Google účtu';

      if (e.code == 'account-exists-with-different-credential') {
        errorMessage =
            'Účet s tímto emailem již existuje, ale s jiným poskytovatelem přihlášení.';
      } else if (e.code == 'invalid-credential') {
        errorMessage = 'Poskytnuté přihlašovací údaje jsou neplatné.';
      } else if (e.code == 'operation-not-allowed') {
        errorMessage = 'Google přihlášení není povoleno.';
      } else if (e.code == 'user-disabled') {
        errorMessage = 'Tento uživatelský účet byl deaktivován.';
      } else if (e.code == 'user-not-found') {
        errorMessage = 'Uživatel s tímto emailem neexistuje.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Neplatné heslo.';
      }

      throw Exception(errorMessage);
    } catch (e) {
      log('Google Sign In general error: $e');
      throw Exception(
          'Došlo k neočekávané chybě při Google přihlášení. Zkuste to prosím znovu.');
    }
  }

  Future<User?> logInUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password); // Aktualizuj cache po úspěšném přihlášení
      if (cred.user != null) {
        await _cacheService.setUserInfo(
          isLoggedIn: true,
          uid: cred.user!.uid,
          email: cred.user!.email,
        );
      }

      return cred.user;
    } catch (e) {
      return null;
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

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _cacheService.clearAllCache();
    } catch (e) {
      await _cacheService.clearAllCache();
      print(e.toString());
    }
  }

  Future<String?> getIdToken() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final token = await user.getIdToken();
        await _cacheService.setUserInfo(
          isLoggedIn: true,
          uid: user.uid,
          email: user.email,
        );
        return token;
      } else {
        final cachedStatus = await _cacheService.getUserLoggedInStatus();
        if (cachedStatus == true) {
          log('User is cached as logged in, but no Firebase user available');
        }
        return null;
      }
    } catch (e) {
      log('Error getting token: $e');
      final userInfo = await _cacheService.getUserInfo();
      if (userInfo['isLoggedIn'] == true) {
        log('User is cached as logged in, but token is not available offline');
      }
      print(e.toString());
      return null;
    }
  }

  Future<bool> isUserLoggedInAsync() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _cacheService.setUserInfo(
          isLoggedIn: true,
          uid: user.uid,
          email: user.email,
        );
        return true;
      } else {
        return false;
      }
    } catch (e) {
      final cachedStatus = await _cacheService.getUserLoggedInStatus();
      if (cachedStatus == true) {
        return true;
      }
      return false;
    }
  }

  Future<UserCredential?> loginWithFacebook() async {
    try {
      throw Exception('Přihlášení pomocí Facebooku není zatím implementováno.');
    } on FirebaseAuthException catch (e) {
      log('Facebook Sign In Firebase Auth error: ${e.code}');
      String errorMessage = 'Chyba při přihlášení pomocí Facebook účtu';

      if (e.code == 'account-exists-with-different-credential') {
        errorMessage =
            'Účet s tímto emailem již existuje, ale s jiným poskytovatelem přihlášení.';
      } else if (e.code == 'invalid-credential') {
        errorMessage = 'Poskytnuté přihlašovací údaje jsou neplatné.';
      } else if (e.code == 'operation-not-allowed') {
        errorMessage = 'Facebook přihlášení není povoleno.';
      } else if (e.code == 'user-disabled') {
        errorMessage = 'Tento uživatelský účet byl deaktivován.';
      } else if (e.code == 'user-not-found') {
        errorMessage = 'Uživatel s tímto emailem neexistuje.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Neplatné heslo.';
      }

      throw Exception(errorMessage);
    } catch (e) {
      log('Facebook Sign In general error: $e');
      throw Exception(
          'Došlo k neočekávané chybě při Facebook přihlášení. Zkuste to prosím znovu.');
    }
  }

  Future<String> getUserUidAsync() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        log('User UID: ${user.uid}');

        // Aktualizuj cache
        await _cacheService.setUserUid(user.uid);

        return user.uid;
      } else {
        log('User is not logged in');
        return "-1";
      }
    } catch (e) {
      log('Error getting user UID: $e');

      // Při chybě zkus načíst z cache
      final cachedUid = await _cacheService.getUserUid();
      if (cachedUid != null && cachedUid.isNotEmpty) {
        log('User UID loaded from cache: $cachedUid');
        return cachedUid;
      }

      return "-1";
    }
  }

  String? getUserUid() {
    final user = _auth.currentUser;
    return user?.uid;
  }
}
