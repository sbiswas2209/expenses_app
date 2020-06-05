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
  bool _loadingState = false;
  String type='Miscellaneous';
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
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.document('users/${user.uid}').snapshots(),
      builder: (context , snapshot){
        return !snapshot.hasData ? LinearProgressIndicator() :
        ListView(
          children: <Widget>[
            Card(
              color: Color(0XFF5b5656),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('Total Expenditure',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('${snapshot.data['total']}',
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
                  child: Text('${snapshot.data['$type']}',
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
                        child: Text('Table',
                          style: TextStyle(
                            color: Colors.white,
                          fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Table(
                      border: TableBorder.all(),
                      children: [
                        TableRow(
                          children: <Widget>[
                            Center(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Transport',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            )),
                            Center(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${snapshot.data['Transport']}',
                                style: TextStyle(
                                  color: Color(0XFF7fcd91),
                                  fontSize: 20.0,
                                ),
                              ),
                            )),
                          ],
                        ),
                        TableRow(
                          children: <Widget>[
                            Center(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Telephone',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            )),
                            Center(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${snapshot.data['Telephone']}',
                                style: TextStyle(
                                  color: Color(0XFF7fcd91),
                                  fontSize: 20.0,
                                ),
                              ),
                            )),
                          ],
                        ),
                        TableRow(
                          children: <Widget>[
                            Center(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Stationery',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            )),
                            Center(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${snapshot.data['Stationery']}',
                                style: TextStyle(
                                  color: Color(0XFF7fcd91),
                                  fontSize: 20.0,
                                ),
                              ),
                            )),
                          ],
                        ),
                        TableRow(
                          children: <Widget>[
                            Center(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Shopping',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            )),
                            Center(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${snapshot.data['Shopping']}',
                                style: TextStyle(
                                  color: Color(0XFF7fcd91),
                                  fontSize: 20.0,
                                ),
                              ),
                            )),
                          ],
                        ),
                        TableRow(
                          children: <Widget>[
                            Center(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Rent',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            )),
                            Center(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${snapshot.data['Rent']}',
                                style: TextStyle(
                                  color: Color(0XFF7fcd91),
                                  fontSize: 20.0,
                                ),
                              ),
                            )),
                          ],
                        ),
                        TableRow(
                          children: <Widget>[
                            Center(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Personal',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            )),
                            Center(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${snapshot.data['Personal']}',
                                style: TextStyle(
                                  color: Color(0XFF7fcd91),
                                  fontSize: 20.0,
                                ),
                              ),
                            )),
                          ],
                        ),
                        TableRow(
                          children: <Widget>[
                            Center(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Office',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            )),
                            Center(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${snapshot.data['Office']}',
                                style: TextStyle(
                                  color: Color(0XFF7fcd91),
                                  fontSize: 20.0,
                                ),
                              ),
                            )),
                          ],
                        ),
                        TableRow(
                          children: <Widget>[
                            Center(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Miscellaneous',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            )),
                            Center(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${snapshot.data['Miscellaneous']}',
                                style: TextStyle(
                                  color: Color(0XFF7fcd91),
                                  fontSize: 20.0,
                                ),
                              ),
                            )),
                          ],
                        ),
                        TableRow(
                          children: <Widget>[
                            Center(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Household',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            )),
                            Center(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${snapshot.data['Household']}',
                                style: TextStyle(
                                  color: Color(0XFF7fcd91),
                                  fontSize: 20.0,
                                ),
                              ),
                            )),
                          ],
                        ),
                        TableRow(
                          children: <Widget>[
                            Center(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Food',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            )),
                            Center(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${snapshot.data['Food']}',
                                style: TextStyle(
                                  color: Color(0XFF7fcd91),
                                  fontSize: 20.0,
                                ),
                              ),
                            )),
                          ],
                        ),
                        TableRow(
                          children: <Widget>[
                            Center(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Entertainment',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            )),
                            Center(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${snapshot.data['Entertainment']}',
                                style: TextStyle(
                                  color: Color(0XFF7fcd91),
                                  fontSize: 20.0,
                                ),
                              ),
                            )),
                          ],
                        ),
                        TableRow(
                          children: <Widget>[
                            Center(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Educational',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            )),
                            Center(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${snapshot.data['Educational']}',
                                style: TextStyle(
                                  color: Color(0XFF7fcd91),
                                  fontSize: 20.0,
                                ),
                              ),
                            )),
                          ],
                        ),
                        TableRow(
                          children: <Widget>[
                            Center(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Conveyance',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            )),
                            Center(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${snapshot.data['Conveyance']}',
                                style: TextStyle(
                                  color: Color(0XFF7fcd91),
                                  fontSize: 20.0,
                                ),
                              ),
                            )),
                          ],
                        ),
                        TableRow(
                          children: <Widget>[
                            Center(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Beauty',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            )),
                            Center(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${snapshot.data['Beauty']}',
                                style: TextStyle(
                                  color: Color(0XFF7fcd91),
                                  fontSize: 20.0,
                                ),
                              ),
                            )),
                          ],
                        ),
                        ],
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
                              _loadingState = true;
                            });
                            double total = await new DatabaseService(uid: user.uid).filterMonths(start, end);
                            double total_category = await new DatabaseService(uid: user.uid).filterCategoryMonths(start, end, type);
                            setState(() {
                              _loadingState = false;
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
                    child: _loadingState ? Center(child: CircularProgressIndicator(),):
                              Text(total_month_filter == null ? 'Loading' : '$total_month_filter',
                                  style: TextStyle(
                                      color: Color(0XFF7fcd91),
                                      fontSize: 20.0,
                      ),
                    ),
                  ),
                  Text('Total $type Expenditures within this period :',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _loadingState ? Center(child: CircularProgressIndicator())
                        :Text(snapshot.data[type] == 0.0 ? 'No Expenses to show.' : total_category_month_filter == null ? 'Loading' : '$total_category_month_filter',
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
      },
    );
  }
}