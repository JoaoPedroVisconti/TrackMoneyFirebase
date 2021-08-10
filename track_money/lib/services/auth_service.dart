import 'package:track_money/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create a User object base on Firebase
  UserModel? _userFromFirebaseUser(User? user) {
    return user != null ? (UserModel(uid: user.uid)) : null;
  }

  // Stream to listen to the user
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // Login Anon
  Future loginAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();

      User? user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Login with email and password

  // Register with email and password

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