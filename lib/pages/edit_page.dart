import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_calculator/model/user.dart';
import 'package:expenses_calculator/services/database.dart';
import 'package:flutter/material.dart';
class EditPage extends StatefulWidget {
  final DocumentSnapshot data;
  final User user;
  EditPage({this.data , this.user});
  @override
  _EditPageState createState() => _EditPageState(data: this.data , user: user);
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();
  
  final User user;
  final DocumentSnapshot data;
  _EditPageState({this.data , this.user});
  String _type , _title , _content , _oldType;
  double _amount;
  DateTime _dateTime = DateTime.now();
  _updateValue(String title , String content , String type , double amount , DateTime date){
    setState(() {
      _title = title;
      _content = content;
      _type = type;
      _amount = amount;
      _dateTime = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    DatabaseService database = new DatabaseService(uid: this.user.uid);
    _title = _title == null ? data['title'] : _title;
     _content = _content == null ? data['content'] : _content;
     _type = _type == null ? data['type'] : _type;
     _oldType = data['type'];
    _amount = _amount == null ? data['amount'] : _amount;
    print(_oldType);
    return Scaffold(
      backgroundColor: Color(0XFF000000),
      appBar: AppBar(
        backgroundColor: Color(0XFF7fcd91),
        title: Text('Edit Page',
          style: TextStyle(
            color: Color(0XFF5b5656),
            fontSize: 20.0,
          ),
        ),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              database.increaseTotal(data['amount'],_amount , _oldType , _type);
              Firestore.instance.runTransaction((transaction) async {
                DocumentSnapshot freshSnap = await transaction.get(data.reference);
                await transaction.update(freshSnap.reference, 
                  {
                    'title' : _title,
                    'content' : _content,
                    'type' : _type,
                    'amount' : _amount,
                    'date' : _dateTime,
                  }
                );
                
                int count = 0;
                Navigator.popUntil(context , (route) {
                  return count++ ==2;
                });
              });
            }, 
            icon: Icon(Icons.save), 
            label: Text('Save'),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
                  child: Column(
            children: <Widget>[
              SizedBox(height:10),
              Text('Title',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Card(
                  color: Color(0XFF5b5656),
                  child: TextFormField(
                    initialValue: _title,
                    decoration: InputDecoration(
                      filled: true,
                      focusColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: 'Title',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      )
                    ),
                    onChanged: (value) => _updateValue(value, _content, _type, _amount , _dateTime),
                  ),
                ),
              ),
              Text('Content',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Card(
                  color: Color(0XFF5b5656),
                  child: TextFormField(
                    minLines: 1,
                    maxLines: 20,
                    initialValue: _content,
                    decoration: InputDecoration(
                      filled: true,
                      focusColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: 'Content',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      )
                    ),
                    onChanged: (value) => _updateValue(_title, value, _type, _amount , _dateTime),
                  ),
                ),
              ),
              Text('Amount',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Card(
                  color: Color(0XFF5b5656),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: _amount.toString(),
                    decoration: InputDecoration(
                      filled: true,
                      focusColor: Colors.white,
                      border: OutlineInputBorder(),
                      hintText: 'Amount',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      )
                    ),
                    onChanged: (value) => _updateValue(_title, _content, _type, double.parse(value) , _dateTime),
                  ),
                ),
              ),
              Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: RaisedButton.icon(
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: _dateTime == null ? DateTime.now() : _dateTime,
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          ).then((date) => _updateValue(_title, _content, _type, _amount, date),)
                          ;
                        },
                        label: Text(_dateTime == null ? DateTime.now().toString() : _dateTime.toString()),
                        icon: Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
               Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: DropdownButton(
                      dropdownColor: Color(0XFF5b5656),
                      value: _type,
                      icon: Icon(Icons.arrow_downward),
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
                      onChanged: (value) => _updateValue(_title, _content, value, _amount, _dateTime)
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}