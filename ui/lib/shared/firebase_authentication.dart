import 'package:ui/views/app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

class FirebaseAuthentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> createUser(String email, String password) async {
    try {
      UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential.user!.uid;
    } on FirebaseAuthException {
      return null;
    }
  }

  Future<String?> loginWithUserID(String userID) async {
    try {
      UserCredential credential = await _firebaseAuth.signInAnonymously();
      return credential.user!.uid;
    } on FirebaseAuthException {
      return null;
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      UserCredential credential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return credential.user!.uid;
    } on FirebaseAuthException {
      return null;
    }
  }

  Future<bool> logout() async {
    try {
      _firebaseAuth.signOut();
      return true;
    } on FirebaseAuthException {
      return false;
    }
  }

  Future<UserCredential> loginWithGoogle() async {
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
    googleProvider.setCustomParameters({
      'login_hint': 'user@example.com'
    });

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithPopup(googleProvider);

    // Or use signInWithRedirect
    // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
  }

}
