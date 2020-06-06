import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_calculator/model/category.dart';
import 'package:expenses_calculator/model/user.dart';
import 'package:expenses_calculator/pages/bar_graph.dart';
import 'package:expenses_calculator/services/database.dart';
import 'package:flutter/material.dart';
class DashBoardPage extends StatefulWidget {
  final String tag = 'dashboard-page';
  final User user;
  DashBoardPage({this.user});
  @override
  _DashBoardPageState createState() => _DashBoardPageState(user: user);
}

class _DashBoardPageState extends State<DashBoardPage> {
  bool loading = true;
  bool _loadingState = true;
  String type='Miscellaneous';
  double total = 0.0;
  int index = 0;
  List categories = ['Food',
                                    'Stationery',
                                    'Office',
                                    'Conveyance',
                                    'Entertainment',
                                    'Shopping',
                                    'Household',
                                    'Telephone',
                                    'Rent',
                                    'Transport',
                                    'Personal',
                                    'Beauty',
                                    'Educational',
                                    'Miscellaneous'
                    ];
  double category_data=0.0;
  String filter_type = 'Miscellaneous';
  double total_month_filter = 0.0;
  double total_category_month_filter = 0.0;
  String month = 'January';
  DateTime start = DateTime.now();
  DateTime end = DateTime.now();
  final User user;
  _DashBoardPageState({this.user});
  
  Future<void> _showDateErrorDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Date Range error'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('End date is before start date.'),
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
_calculateTotal() async {
  DatabaseService data = new DatabaseService(uid:user.uid);
  double total = await data.calculateTotal();
  return total;
}
_calculateCategoryTotal(String type) async {
    DatabaseService data = new DatabaseService(uid: user.uid);
    double total;
    total = await data.calculateCategoryTotal(type);
    return total;
}
@override
void initState(){
  super.initState();
  setState(() {
    _loadingState = true;
  });
  _calculateCategoryTotal('Miscellaneous').then((value){
    print(value);
    setState(() {
      category_data = value;
      loading  = false;
    });
  });
  print(category_data);
  _calculateTotal().then((value){
    setState(() {
      total = value;
    });
  });
  setState(() {
    _loadingState = false;
  });
}
  @override
  Widget build(BuildContext context) {
    return _loadingState == true ? LinearProgressIndicator() :
        ListView(
          children: <Widget>[
            Card(
              color: Color(0XFF5b5656),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Center(
                        child: Text('Total Expenditure',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('$total',
                        style: TextStyle(
                          color: Color(0XFF7fcd91),
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                  // BarGraph(
                  //     data: snapshot.data,
                  //     type: 'total',
                  //   ),
                ],
              ),
            ),
            Card(
            color: Color(0XFF5b5656),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text('Total Categorical Data',
                      style: TextStyle(
                        color: Colors.white,
                          fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: DropdownButton(
                    dropdownColor: Color(0XFF5b5656),
                    value: type,
                    icon: Icon(Icons.arrow_downward , color: Colors.white),
                    iconSize: 20.0,
                    elevation: 20,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                    underline: Container(
                      height: 5,
                      color: Colors.white,
                    ),
                    items: <String>['Food',
                                    'Stationery',
                                    'Office',
                                    'Conveyance',
                                    'Entertainment',
                                    'Shopping',
                                    'Household',
                                    'Telephone',
                                    'Rent',
                                    'Transport',
                                    'Personal',
                                    'Beauty',
                                    'Educational',
                                    'Miscellaneous'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        type = value;
                        loading = true;
                      });
                      _calculateCategoryTotal(value).then((value){
                        setState(() {
                          category_data = value;
                          loading = false;
                        });
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('$type',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: loading ? Center(child: CircularProgressIndicator(strokeWidth: 1.0,),)
                  : Text('$category_data',
                    style: TextStyle(
                      color: Color(0XFF7fcd91),
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
              ),
              Card(
              color: Color(0XFF5b5656),
              child: Column(
                children: <Widget>[
                  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.filter_list),
                    SizedBox(width:10),
                    Text('Filter by Date',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text('Start Date',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize:15.0,
                  ),
                ),
              ),
            ),
            Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Color(0XFF5b5656),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(start == null ? DateTime.now().toString() : start.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                      child: RaisedButton.icon(
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: start == null ? DateTime.now() : start,
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          ).then((date) {
                            setState(() {
                              start = date;
                            });
                          })
                          ;
                        },
                        label: Text('Choose Start Date'),
                        icon: Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text('End Date',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize:15.0,
                  ),
                ),
              ),
            ),
            Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Color(0XFF5b5656),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(end == null ? DateTime.now().toString() : end.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                      child: RaisedButton.icon(
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: end == null ? DateTime.now() : end,
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          ).then((date) {
                            setState(() {
                              end = date;
                            });
                          })
                          ;
                        },
                        label: Text('Choose End Date'),
                        icon: Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('Choose Category',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: DropdownButton(
                    dropdownColor: Color(0XFF5b5656),
                    value: filter_type,
                    icon: Icon(Icons.arrow_downward , color: Colors.white),
                    iconSize: 20.0,
                    elevation: 20,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                    underline: Container(
                      height: 5,
                      color: Colors.white,
                    ),
                    items: <String>['Food',
                                    'Stationery',
                                    'Office',
                                    'Conveyance',
                                    'Entertainment',
                                    'Shopping',
                                    'Household',
                                    'Telephone',
                                    'Rent',
                                    'Transport',
                                    'Personal',
                                    'Beauty',
                                    'Educational',
                                    'Miscellaneous'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        filter_type = value;
                      });
                    },
                  ),
                ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Card(
                      child: RaisedButton(
                        child: Text('Submit Data'),
                        onPressed: () async {
                          if(end.isBefore(start)){
                            _showDateErrorDialog(context);
                          }
                          else{
                            setState(() {
                              loading = true;
                            });
                            double total = await new DatabaseService(uid: user.uid).filterMonths(start, end);
                            double total_category = await new DatabaseService(uid: user.uid).filterCategoryMonths(start, end, filter_type);
                            setState(() {
                              loading = false;
                              total_month_filter = total;
                              total_category_month_filter = total_category;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  Text('Total Expenditures within this period :',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: loading ? Center(child: CircularProgressIndicator(strokeWidth: 1.0,),):
                              Text(total_month_filter == 0.0 ? 'Nothing to show.' : '$total_month_filter',
                                  style: TextStyle(
                                      color: Color(0XFF7fcd91),
                                      fontSize: 20.0,
                      ),
                    ),
                  ),
                  Text('Total $filter_type Expenditures within this period :',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: loading ? Center(child: CircularProgressIndicator(strokeWidth: 1.0,))
                        :Text(total_category_month_filter == 0.0 ? 'Nothing to show.' : '$total_category_month_filter',
                      style: TextStyle(
                        color: Color(0XFF7fcd91),
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  SizedBox(height:50),
                ],
              ),
            ),
          ],
        );
  }
}