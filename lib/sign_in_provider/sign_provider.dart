import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class SignInProvider extends ChangeNotifier {
  bool _hasError = false;
  String _errorCode = "";
  final FacebookAuth facebookAuth = FacebookAuth.instance;

  Future signInWithFacebook() async {
    final LoginResult result = await facebookAuth.login();
    final graphResponse = await http.get(Uri.parse(
        'https://graph.facebook.com/v2.12/me?fields=name,picture.width(800).height(800),first_name,last_name,email&access_token=${result
            .accessToken!.token}'));
    final profile = jsonDecode(graphResponse.body);
    if (result.status == LoginStatus.success) {
      try {
        final OAuthCredential credential = FacebookAuthProvider.credential(
            result.accessToken!.token);
        await FirebaseAuth.instance.signInWithCredential(credential);
        await FirebaseFirestore.instance.collection('users').doc(
            FirebaseAuth.instance.currentUser!.uid).set(
            {
              'name': profile['name'],
              'email': profile['email'],
              'uid': FirebaseAuth.instance.currentUser!.uid,
              'profileImage': profile['picture']['data']['url'],
              'provider': 'Facebook',
            });
      } on FirebaseAuthException catch (e) {
        switch (e) {
          case " account-exist-with-different-credintials":
            _errorCode = "You already have with us. Use correct Provider";
            _hasError = true;
            notifyListeners();
            break;
          case "null":
            _errorCode = "Some unexpected error while trying to sign in";
            _hasError = true;
            notifyListeners();
            break;
        }
      }
    } else {
      _hasError = true;
      notifyListeners();
    }
  }

  String get provider => provider;

//------google signIn------
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!
          .authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential authResult =
      await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = authResult.user;

      // Now, you can save user information to Firestore
      await saveUserInfoToFirestore(user);
    } catch (error) {
      print('Error signing in with Google: $error');
    }
  }

  Future<void> saveUserInfoToFirestore(User? user) async {
    if (user != null) {
      final CollectionReference usersCollection = FirebaseFirestore.instance
          .collection('users');

      // Create a document with the user's UID
      await usersCollection.doc(user.uid).set({
        'name': user.displayName,
        'email': user.email,
        'uid': user.uid,
        'profileImage': user.photoURL,
        'provider': 'Google', // You can set the provider as needed
      });

      print('User information saved to Firestore');
    }
  }
}
