import 'dart:async';
import 'package:expenses_calculator/model/user.dart';
import 'package:expenses_calculator/services/database.dart';
import 'auth_abstract.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService implements Auth{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User _userfromFirebase(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user{
  return _firebaseAuth.onAuthStateChanged
    .map(_userfromFirebase);
}

  Future<dynamic> signIn(String email , String password) async {
    try{
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    return _userfromFirebase(user);
    }
    catch(e){
      return e.toString();
    }
  }

  Future<dynamic> signUp(String email , String password) async {
    try{
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    await new DatabaseService(uid: user.uid).setUserData(email, password);
    await new DatabaseService(uid: user.uid).setNotesData('Sample Title', 'Sample Content', 'Miscellaneous', 0.0);
    return _userfromFirebase(user);
    }
    catch(e){
      return e.toString();
    }
  }

  dynamic getCurrentUser() async {
    try{
      FirebaseUser user = await _firebaseAuth.currentUser();
      return _userfromFirebase(user);
    }
    catch(e){
      return e.toString();
    }
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<bool> isVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }

}