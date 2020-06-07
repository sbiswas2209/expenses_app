import 'package:expenses_calculator/services/database.dart';
import 'package:flutter/material.dart';
class NoteFromImage extends StatefulWidget {
  static final String tag = 'note-from-image';
  final String uid;
  final String title;
  final double amount;
  NoteFromImage({this.uid,this.title,this.amount});
  @override
  _NoteFromImageState createState() => _NoteFromImageState(uid: this.uid , title: this.title , amount: this.amount);
}

class _NoteFromImageState extends State<NoteFromImage> {
  final _formKey = GlobalKey<FormState>();
  final String title;
  final double amount;
  final String uid;
  _NoteFromImageState({this.uid,this.title,this.amount});
  String _title;
  double _amount;
  String _type = 'Miscellaneous';
  String _content = 'Some content here.';
  DateTime _dateTime = DateTime.now();
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
void initState(){
  super.initState();
  setState(() {
    _title = title;
    _amount = amount;
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0XFF7fcd91),
        title: Text('Edit details',
          style: TextStyle(
            color: Color(0XFF5b5656)
          ),
        ),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              if(_title == null || _content == null || _type == null || _amount == null){
                _showNullFieldDialog(context);
              }
              else{
                new DatabaseService(uid: this.uid).setNotesData(_title, _content, _type, _amount, _dateTime);
                int count = 0;
              Navigator.popUntil(context , (route) {
              return count++ == 3; 
            });
              }
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
                    onChanged: (value) {
                      setState(() {
                        _title = value;
                      });
                    },
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
                    onChanged: (value) {
                      setState(() {
                        _content = value;
                      });
                    },
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
                    onChanged: (value) {
                      setState(() {
                        _amount = double.parse(value);
                      });
                    },
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
                          ).then((date) {
                            setState(() {
                              _dateTime = date;
                            });
                          },)
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
                      onChanged: (value) {
                        setState(() {
                          _type = value;
                        });
                      }
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}