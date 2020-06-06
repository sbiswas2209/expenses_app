

import 'package:expenses_calculator/authentication/login_page.dart';
import 'package:expenses_calculator/authentication/sign_up_page.dart';
import 'package:expenses_calculator/authentication/start_screen.dart';
import 'package:expenses_calculator/pages/new_note.dart';
import 'package:expenses_calculator/pages/pickImage.dart';
import 'package:expenses_calculator/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/user.dart';
import 'wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
final routes = <String , WidgetBuilder>{
  LoginPage.tag : (context) => LoginPage(),
  SignUpPage.tag : (context) => SignUpPage(),
  StartScreen.tag : (context) => StartScreen(),
  NewItemPage.tag : (context) => NewItemPage(),
  PickImage.tag : (context) => PickImage(),
};

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
          value: AuthService().user,
          child: MaterialApp(
            home: Wrapper(),
            routes: routes,
            debugShowCheckedModeBanner: false,
          ),
    );
  }
}
