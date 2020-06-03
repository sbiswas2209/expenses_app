import 'dart:async';
import 'package:expenses_calculator/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class Auth {
  
  Future<dynamic> signIn(String email , String password);

  Future<dynamic> signUp(String email , String password);

  dynamic getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isVerified();

}