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
  String type='Miscellaneous';
  final User user;
  _DashBoardPageState({this.user});
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
                    child: Text('Categorical Data',
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
          ],
        );
      },
    );
  }
}