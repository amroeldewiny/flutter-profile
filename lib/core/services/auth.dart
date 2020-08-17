import 'dart:async';
import 'package:baobabart/core/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:baobabart/core/services/database.dart';
import 'package:baobabart/core/services/task.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object from firebase user data
  User _firebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // Auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_firebaseUser);
  }

  // SignIn user with email && password
  Future signInUser(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // Register new user with email && passwored
  Future registerUser(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      // create new document for the new user with uid
      await DatabaseService(uid: user.uid).updateUserData(
          user.uid, 'New User', email, 'working in Nikkel Art', 'no_user.png');
      // create new document todo for each user with uid
      await TaskService(uid: user.uid).updateTaskData(
          user.uid, 'First todo', 'Update my todos list', false);
      return _firebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // get current user
  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _auth.currentUser();
    return user;
  }

  currentUser() async {
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    return uid;
  }

  // verification to each new registred user
  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _auth.currentUser();
    user.sendEmailVerification();
  }

  // check user get verified email
  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _auth.currentUser();
    return user.isEmailVerified;
  }

  Future<void> resetMail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
    return null;
  }

  // Logout user
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
