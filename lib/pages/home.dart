import 'package:expenses_calculator/model/user.dart';
import 'package:expenses_calculator/pages/accountPage.dart';
import 'package:expenses_calculator/pages/dashBoardPage.dart';
import 'package:expenses_calculator/pages/dashWrapper.dart';
import 'package:expenses_calculator/pages/homePage.dart';
import 'package:expenses_calculator/pages/new_note.dart';
import 'package:expenses_calculator/services/auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  static final String tag = 'home-page';
  final User user;
  MainPage({this.user});
  @override
  _MainPageState createState() => _MainPageState(user: user);
}

class _MainPageState extends State<MainPage> {

final User user;
_MainPageState({this.user});

 
static int _index = 0;
void _updateIndex(int newIndex){
  setState(() {
    _index = newIndex;
  });
}
  final AuthService _firebaseAuth = new AuthService();
  @override
  Widget build(BuildContext context) {
    List<Widget> _bodyList = <Widget>[
   HomePage(user: user),
   DashBoardPage(user: user),
 ];
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0XFF5b5656),
        title: Text('Expenses',
          style: TextStyle(
            color: Color(0XFFf5eaea),
            fontSize: 20.0,
            //fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.push(context , new MaterialPageRoute(
              builder: (BuildContext context) => new AccountPage(user: user)
            )), 
            child: Icon(Icons.person , color: Colors.white,),
          ),
          FlatButton(
            onPressed: () async {
              await _firebaseAuth.signOut();
            },
             child: Icon(Icons.exit_to_app , color: Colors.white,),
             ),
        ],
      ),
      body: _bodyList[_index],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add , color: Color(0XFF4d4646)),
        backgroundColor: Color(0XFF7fcd91),
        onPressed: (){
          Navigator.push(context, new MaterialPageRoute(
            builder: (BuildContext context) => new NewItemPage(uid: user.uid)
          ));
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0XFF4d4646),
        
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0XFF7fcd91),
        ),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home , color: Color(0XFFf5eaea),),
            title: Text('Home',
              style: TextStyle(
                color: Color(0XFFf5eaea),
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart , color: Color(0XFFf5eaea),),
            title: Text('Dashboard',
              style: TextStyle(
                color: Color(0XFFf5eaea),
              ),
            ),
          ),
        ],
        currentIndex: _index,
        onTap: _updateIndex,
        selectedItemColor: Color(0XFF7fcd91),
        unselectedItemColor: Color(0XFFf5eaea),
      ),
    );
  }
}