import 'dart:developer';

import 'package:dialectos/core/error/exception.dart';
import 'package:dialectos/features/authentication/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthDataSource {
  Future<UserModel> login();
  Future<void> logout();
}

class AuthDataSourceImplementation extends AuthDataSource {
  UserModel getUserModel(User user) {
    return UserModel(
      name: user.displayName!,
      email: user.email!,
      profileUrl: user.photoURL!,
      uid: user.uid,
      emailVerified: user.emailVerified,
      phoneNumber: user.phoneNumber ?? "",
      refreshToken: user.refreshToken!,
    );
  }

  @override
  Future<UserModel> login() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
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
          return getUserModel(user);
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
              return getUserModel(user);
            }
          } on FirebaseAuthException catch (e) {
            log('Failed to sign up user: ${e.message}');
            throw SignInException();
          }
        } else {
          log('Failed to sign in user: ${e.message}');
          throw SignInException();
        }
      }
    }
    log("No account selected");
    throw NoAccountSelectedException();
  }

  @override
  Future<void> logout() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.signOut();
      await GoogleSignIn().signOut();
      log('User is signed out');
    } catch (e) {
      log('Failed to sign out user: $e');
      throw SignOutException();
    }
  }
}