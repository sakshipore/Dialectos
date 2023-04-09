import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  Future<User?> signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    final FirebaseAuth auth = FirebaseAuth.instance;

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          log('User ${user.uid} is signed in');
          return user;
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          // If the user is not already registered, sign up the user
          try {
            final UserCredential userCredential =
                await auth.createUserWithEmailAndPassword(
              email: googleSignInAccount.email,
              password: googleSignInAccount.id,
            );
            final User? user = userCredential.user;

            if (user != null) {
              log('User ${user.uid} is signed up and signed in');
              return user;
            }
          } on FirebaseAuthException catch (e) {
            log('Failed to sign up user: ${e.message}');
            return null;
          }
        } else {
          log('Failed to sign in user: ${e.message}');
          return null;
        }
      }
    }
    log("No account selected");
    return null;
  }

  Future<void> signOut() async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth.signOut();
      await GoogleSignIn().signOut();
      log('User is signed out');
    } catch (e) {
      log('Failed to sign out user: $e');
    }
  }
}
