import 'package:expenses_calculator/model/note.dart';
import 'package:expenses_calculator/model/user.dart';
import 'package:expenses_calculator/pages/fullPage.dart';
import 'package:expenses_calculator/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_calculator/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class HomePage extends StatefulWidget {
  final User user;
  HomePage({this.user});
  @override
  _HomePageState createState() => _HomePageState(user: user);
}

class _HomePageState extends State<HomePage> {

  final User user;
  _HomePageState({this.user});

Future<void> _deleteItemDialog(BuildContext context , DocumentSnapshot data) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
          title: Text('Delete item',
            style: TextStyle(
      fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
      children: <Widget>[
        Text('Are you sure you want to delete the item?'),
        Text('This is not recoverable.'),
      ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
      child: Text('Delete'),
      onPressed: () {
        new DatabaseService(uid: user.uid).deleteNote(data);
        Navigator.of(context).pop();
      },
            ),
            FlatButton(
      child: Text('No'),
      onPressed: () {
        Navigator.of(context).pop();
      },
            ),
          ],
        );
    },
  );
}
  
  @override
  Widget build(BuildContext context) {

    
    return StreamBuilder(
      stream: Firestore.instance.collection('users/${user.uid}/notes').snapshots(),
      builder: (context, snapshot) {
        return !snapshot.hasData ? 
          LinearProgressIndicator() :
          ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context , index) {
              return !snapshot.hasData ? LinearProgressIndicator():
              GestureDetector(
                              child: Card(
                  color: Color(0XFF5b5656),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.assignment),
                    ),
                    title: Text(snapshot.data.documents[index]['title'],
                      style: TextStyle(
                        color: Color(0XFFf5eaea),
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                onTap: () => Navigator.push(context, new MaterialPageRoute(
                  builder: (BuildContext context) => new FullPage(data: snapshot.data.documents[index] , user: user),
                )),
                onLongPress: () => _deleteItemDialog(context, snapshot.data.documents[index]),
              );
            },
          );
      },
    );

    
  }
}