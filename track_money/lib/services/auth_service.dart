import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:track_money/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:track_money/services/database_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Collection reference
  final FirebaseFirestore db = FirebaseFirestore.instance;

  // Create a User object base on Firebase
  UserModel? _userFromFirebaseUser(User? user) {
    return user != null ? (UserModel(uid: user.uid)) : null;
  }

  // Stream to listen to the user
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // Login with email and password
  Future loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Register with email and password
  Future registerWithEmailAndPassword(
      String email, String password, String username) async {
    db.doc('/users/$username').get().then((doc) async {
      if (!doc.exists) {
        try {
          UserCredential result = await _auth.createUserWithEmailAndPassword(
              email: email, password: password);

          User? user = result.user;

          // await DatabaseService(uid: user!.uid).createWallet('New Wallet', '', 0);
          // await DatabaseService(uid: user!.uid).createUser(user.uid, username, email);
          db.doc('/users/$username').set({
            'userId': user!.uid,
            'username': username,
            'email': email,
          });

          return _userFromFirebaseUser(user);
        } catch (e) {
          print(e);
          return null;
        }
      } else {
        print('Username already taken');
        return null;
      }
    });
  }

  // Logout user
  Future userLogout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
