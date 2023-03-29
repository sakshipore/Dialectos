import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  final GoogleSignIn googleSignIn = GoogleSignIn();
                  // Start the Google sign-in process
                  final GoogleSignInAccount? googleUser =
                      await googleSignIn.signIn();
                  if (googleUser == null) {
                    // User cancelled the sign-in process
                    throw FirebaseAuthException(
                      code: 'ERROR_ABORTED_BY_USER',
                      message: 'Sign-in process was aborted by the user.',
                    );
                  }

                  // Obtain the Google auth details
                  final GoogleSignInAuthentication googleAuth =
                      await googleUser.authentication;

                  // Create a Firebase credential with the Google auth details
                  final credential = GoogleAuthProvider.credential(
                    accessToken: googleAuth.accessToken,
                    idToken: googleAuth.idToken,
                  );

                  // Sign in to Firebase with the Google credential
                  await FirebaseAuth.instance.signInWithCredential(credential);
                },
                child: Text('Sign in'),
              ),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: () async {
                  User? user = FirebaseAuth.instance.currentUser;
                  final storage = FirebaseStorage.instance;
                  final directory =
                      await FilePicker.platform.getDirectoryPath();
                  final audioDir = Directory(directory!);
                  final List<String> audioUrls = [];

                  int i = 1;

                  await for (var file in audioDir.list()) {
                    final filePath = file.path;
                    String fileName = filePath.split('/').last;
                    fileName = fileName.split('.').first;
                    final ref = storage.ref().child(filePath);
                    final uploadTask = ref.putFile(File(filePath));
                    final snapshot = await uploadTask.whenComplete(() => log(
                        "-----------------------Uploaded------------------------"));
                    final downloadUrl = await snapshot.ref.getDownloadURL();
                    audioUrls.add(downloadUrl);

                    final docRef = FirebaseFirestore.instance
                        .collection('accents')
                        .doc(fileName);

                    await docRef.set({fileName: downloadUrl});
                    log("Done $i");
                    i++;
                  }
                  log("Finished Uploading");
                },
                child: Text('Select Audio Directory'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
