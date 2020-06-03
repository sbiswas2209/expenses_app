import 'package:expenses_calculator/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static final String tag = 'login-page';
  
  @override
  _LoginPageState createState() => _LoginPageState();
  final Function toggleView;
  LoginPage({this.toggleView});
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = null;
  String _password = null;
  bool _loading = false;
    _updateValue(String a , String b){
    setState(() {
      _email = a;
      _password = b;
    });
  }

Future<void> _showNullDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('These Fields cannot be empty'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Please fill up both fields'),
              Text('Do not leave these fields empty.'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> _showCharacterDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('The values must be more than 6 characters long.'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('The values are too short.'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> _showInvalidFieldDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Uh oh! Seems like an error occured.'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Invalid Field'),
              Text('Badly formatted field.'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0XFF7fcd91),
        title: Text('Login Page' ,
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Color(0XFF5b5656),
          ),
        ),
        actions: <Widget>[
          FlatButton(onPressed: () => widget.toggleView(), child: Row(
            children: <Widget>[
              Icon(Icons.person),
              SizedBox(width: 10,),
              Text('Sign Up'),
            ],
            ))
        ],
      ),
          body: Form(
          key: _formKey,
                child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              
              Card(
                color: Color(0XFF5b5656),
                child: Column(
                  children: <Widget>[
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        icon: Icon(Icons.alternate_email , color: Colors.black),
                        hintText: 'Email',
                        fillColor: Color(0XFFcf7500),
                      ),
                      onChanged: (value) => _updateValue(value, _password),
                    ),
                    TextField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        icon: Icon(Icons.enhanced_encryption , color: Colors.black),
                        hintText: 'Password',
                        fillColor: Color(0XFFcf7500),
                      ),
                      onChanged: (value) => _updateValue(_email, value),
                    ),
                      
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(100, 0, 100, 0),
                child: RaisedButton(
                    
                            color: Colors.white.withOpacity(0.8),
                            child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Center(
                  child: Row(
                    // mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.input, color: Colors.black,),
                      SizedBox(
                        width: 10
                      ),
                      Text('Submit' , 
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                            ),
                            onPressed: () async {
                              if(_email == null || _password == null){
                            _showNullDialog(context);
                          }
                          else if(_email.length <= 6 || _password.length <= 6){
                            _showCharacterDialog(context);
                          }
                          else{
                            setState(() {
                              _loading = true;
                            });
                            try{
                              await _auth.signIn(_email, _password);
                            }
                            catch(e){
                              _showNullDialog(context);
                            }
                            
                            
                          }
                            },
                        ),
              ),
              _loading ? Center(child: CircularProgressIndicator()) : SizedBox(),
            ],
          ),
        ),
    );
  }
}