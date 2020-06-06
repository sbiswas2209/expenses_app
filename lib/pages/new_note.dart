import 'package:expenses_calculator/pages/pickImage.dart';
import 'package:expenses_calculator/services/database.dart';
import 'package:flutter/material.dart';
class NewItemPage extends StatefulWidget {
  static final String tag = 'new-item';
  final String uid;
  NewItemPage({this.uid});
  @override
  _NewItemPageState createState() => _NewItemPageState(uid: this.uid);
}

class _NewItemPageState extends State<NewItemPage> {
  final String uid;
  _NewItemPageState({this.uid});
  
  final _formKey = GlobalKey<FormState>();
String _title = null , _content = null , _type = 'Miscellaneous';
double _amount = -9999.9999;
DateTime _dateTime = new DateTime.now();
_updateValue(String a , String b , double c , String d , DateTime date){
  setState(() {
    _title = a;
    _content = b;
    _type = d;
    _amount = c;
    _dateTime = date;
  });
}
Future<void> _showNullFieldDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Please fill in all the fields'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('One or more fields are empty.'),
              Text('Please fill in all the forms.'),
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
    DatabaseService database = new DatabaseService(uid: this.uid);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: <Widget>[
          FlatButton.icon(onPressed: () {
            Navigator.push(context, new MaterialPageRoute(
              builder: (BuildContext context) => new PickImage()
            ));
          }, 
          icon: Icon(Icons.camera_alt), 
          label: Text('Scan Bill'),
          )
        ],
        backgroundColor: Color(0XFF7fcd91),
        title: Text('New Note',
          style: TextStyle(
            color: Color(0XFF4d4646),
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
          body: SingleChildScrollView(
                      child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        focusColor: Colors.white,
                        fillColor: Color(0XFF4d4646),
                        hintText: 'Title',
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
                      onChanged: (value) => _updateValue(value, _content, _amount, _type , _dateTime),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextFormField(
                      minLines: 1,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: 'Content',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                        filled: true,
                        fillColor: Color(0XFF4d4646),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) => _updateValue(_title, value, _amount, _type , _dateTime),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        focusColor: Colors.white,
                        fillColor: Color(0XFF4d4646),
                        hintText: 'Amount',
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
                      onChanged: (value) => _updateValue(_title, _content, double.parse(value), _type , _dateTime),
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
                      onChanged: (value) => _updateValue(_title, _content, _amount, value, _dateTime),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Color(0XFF5b5656),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(_dateTime == null ? DateTime.now().toString() : _dateTime.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      margin: EdgeInsets.fromLTRB(100, 0, 100, 0),
                      child: RaisedButton.icon(
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: _dateTime == null ? DateTime.now() : _dateTime,
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          ).then((date) => _updateValue(_title, _content, _amount, _type, date),)
                          ;
                        },
                        label: Text('Choose Date'),
                        icon: Icon(Icons.calendar_today),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      margin: EdgeInsets.fromLTRB(100, 0, 100, 0),
                      child: RaisedButton.icon(
                        label: Text('Add'),
                        icon: Icon(Icons.add),
                        onPressed: (){
                          if(_title == null || _content == null || _type == null || _amount == -9999.9999){
                            _showNullFieldDialog(context);
                          }
                          else{
                            database.setNotesData(_title, _content, _type, _amount , _dateTime);
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
    );
  }
}