import 'package:expenses_calculator/authentication/start_screen.dart';
import 'package:expenses_calculator/model/user.dart';
import 'package:expenses_calculator/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if(user == null){
      return StartScreen();
    }
    else{
      return MainPage(user:user);
    }
  }
}