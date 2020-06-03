import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_calculator/model/user.dart';
import 'package:expenses_calculator/pages/edit_page.dart';
import 'package:flutter/material.dart';
class FullPage extends StatelessWidget {
  final DocumentSnapshot data;
  final User user;
  FullPage({this.data , this.user});
  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      backgroundColor: Color(0XFF000000),
      appBar: AppBar(
        backgroundColor: Color(0XFF7fcd91),
        title: Text('Full Details',
          style: TextStyle(
            color: Color(0XFF5b5656),
            fontSize: 20.0,
          ),
        ),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () => Navigator.push(context, new MaterialPageRoute(
              builder: (BuildContext context) => new EditPage(data: this.data , user: user),
            )),
            icon: Icon(Icons.edit), 
            label: Text('Edit Fields'),
            ),
        ],
      ),
      body: SingleChildScrollView(
              child: Center(
                child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: <Widget>[
                Text('Title',
                  style: TextStyle(
                    color: Color(0XFF5b5656),
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height:20),
                Text('${data['title']}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 20.0,),
                Text('Content',
                  style: TextStyle(
                    color: Color(0XFF5b5656),
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height:20),
                Text('${data['content']}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 20.0,),
                Text('Amount',
                  style: TextStyle(
                    color: Color(0XFF5b5656),
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height:20),
                Text('${data['amount']}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 20.0,),
                Text('Type',
                  style: TextStyle(
                    color: Color(0XFF5b5656),
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height:20),
                Text('${data['type']}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 20.0,),
            ],
          ),
        ),
              ),
      ),
    );
  }
}