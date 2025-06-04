import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:orgit/services/api/api_client.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
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

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      log('User created: ${cred.user}');
      log('User UID: ${cred.user?.uid}');
      log('User email: ${cred.user?.email}');
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

  Future<bool> isUserProfileComplete() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        log('User is not logged in');
        return false;
      }

      final ApiClient apiClient = ApiClient();
      final response = await apiClient
          .getWithParams('/User/profile-complete/', {'useruid': user.uid});

      if (response != null && response['profile_complete'] != null) {
        final isComplete = response['profile_complete'] as bool;
        log('User profile complete: $isComplete');
        return isComplete;
      }

      log('Could not determine profile completion status');
      return false;
    } catch (e) {
      log('Error checking profile completion: $e');
      return false;
    }
  }

  Future<bool> isUserInGroup() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        log('User is not logged in');
        return false;
      }

      final ApiClient apiClient = ApiClient();
      final response = await apiClient
          .getWithParams('/User/in-group/', {'useruid': user.uid});

      if (response != null && response['in_group'] != null) {
        final inGroup = response['in_group'] as bool;
        log('User in group: $inGroup');
        return inGroup;
      }

      log('Could not determine group membership status');
      return false;
    } catch (e) {
      log('Error checking group membership: $e');
      return false;
    }
  }

  String testdeset() {
    return "test";
  }

  Future<String> determineUserDestination() async {
    try {
      // Krok 1: Kontrola přihlášení
      if (!isUserLoggedIn()) {
        log('User not logged in - redirect to register');
        return 'register';
      }
      // Krok 2: Kontrola profilu
      final bool profileComplete = await isUserProfileComplete();
      if (!profileComplete) {
        log('User profile incomplete - redirect to profile');
        return 'profile';
      }
      // Krok 3: Kontrola členství ve skupině
      final bool inGroup = await isUserInGroup();
      if (!inGroup) {
        log('User not in group - redirect to join_group');
        return 'join_group';
      }
      return 'homepage';
    } catch (e) {
      log('Error determining user destination: $e');
      return 'profile';
    }
  }
}
