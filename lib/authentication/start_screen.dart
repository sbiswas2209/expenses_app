import 'package:expenses_calculator/authentication/login_page.dart';
import 'package:expenses_calculator/authentication/sign_up_page.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  static final String tag = 'start-screen';

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool signInStatus = true;
  void toggleView(){
    setState(() => signInStatus = !signInStatus);
  }

  

  @override
  Widget build(BuildContext context) {
    return signInStatus ? LoginPage(toggleView: toggleView) : SignUpPage(toggleView: toggleView,);
  }
}