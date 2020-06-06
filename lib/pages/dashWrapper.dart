import 'package:expenses_calculator/model/user.dart';
import 'package:expenses_calculator/services/database.dart';
import 'package:flutter/material.dart';
class DashWrapper extends StatefulWidget {
  final User user;
  DashWrapper({this.user});
  @override
  _DashWrapperState createState() => _DashWrapperState(user: user);
}

class _DashWrapperState extends State<DashWrapper> {
  final User user;
  
  _DashWrapperState({this.user});
  bool _loadingState = true;
  double _total = 0.0;
  double _total_category = 0.0;
  String _type = 'Miscellaneous';
  _calculateTotal() async {
    final DatabaseService data = new DatabaseService(uid: user.uid);
    double total = await data.calculateCategoryTotal('Rent');
    return total;
  }
  @override
  void initState() {
    super.initState();
    setState(() {
        _loadingState = true;
      });
    
  
  _calculateTotal().then((value) {
    setState(() {
      _total = value;
      _loadingState = false;
    });
  });
}
  
  @override
  Widget build(BuildContext context) {
    //Future future = await _calculateSum();
    
    return _loadingState ? LinearProgressIndicator():
     Container(
      color: Colors.white,
      child: Text('$_total'),
    );
  }
}