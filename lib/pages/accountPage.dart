import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_calculator/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class AccountPage extends StatelessWidget {
  final User user;
  AccountPage({this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0XFF5b5656),
        title: Text('Account Page',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(0XFFfffffc),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: 'Expenses App',
                applicationIcon: FlutterLogo(),
                applicationVersion: 'v0.0.1',
              );
            }, 
            child: Icon(Icons.info_outline, color: Colors.white,), 
          ),
        ],
      ),
      body: StreamBuilder(
      stream: Firestore.instance.document('users/${this.user.uid}').snapshots(),
      builder: (context , snapshot) {
        return !snapshot.hasData ? LinearProgressIndicator():
        Card(
        color: Color(0XFF5b5656),
        child: Column(
              children: <Widget>[
                SizedBox(height:20),
                CircleAvatar(
        radius: 60.0,
        child:Icon(Icons.person_add ,size: 60,),
                ),
                SizedBox(height:40),
                Center(
        child: Text('Email',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
                ),
                Center(
        child: Text('${snapshot.data['email']}',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
                ),
                SizedBox(height:40),
                Center(
        child: Text('Password',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
                ),
                Center(
        child: Text('${snapshot.data['password']}',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
                ),
              ],
            ),
      );
      },
    ),
    );
  }
}