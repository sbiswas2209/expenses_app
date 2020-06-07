import 'dart:io';
import 'package:expenses_calculator/pages/noteFromImage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
class PickImage extends StatefulWidget {
  static final String tag = 'pick-image';
  final String uid;
  PickImage({this.uid});
  @override
  _PickImageState createState() => _PickImageState(uid: this.uid);
}

class _PickImageState extends State<PickImage> {
  final String uid;
  _PickImageState({this.uid});
  double amount = -9999;
  String title = null;
  bool flag = false;
  bool imageLoaded = false;
  PickedFile pickedImage;
  File image;
  final _picker = ImagePicker();
  bool _loadingStatus = false;

  bool isNumeric(String s){
    if(s==null){
      return false;
    }
    return double.tryParse(s) != null;
  }

  Future pickGalleryImage() async {
    var tempStore = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      pickedImage = tempStore;
      if(pickedImage != null){
      image = File(pickedImage.path);
      imageLoaded = true;
      }
    });
  }
  Future pickCameraImage() async {
    var tempStore = await _picker.getImage(source: ImageSource.camera);
    setState(() {
      pickedImage = tempStore;
      if(pickedImage != null){
      image = File(pickedImage.path);
      imageLoaded = true;
      }
    });
  }

  Future readText() async {
    setState(() {
      _loadingStatus = true;
    });
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(image);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(ourImage);
    for(TextBlock block in readText.blocks){
      for(TextLine line in block.lines){
        for(TextElement word in line.elements){
          if(title == null){
            setState(() {
              title = word.text;
            });
          }
          if(isNumeric(word.text) == true){
            setState(() {
              amount = double.parse(word.text);
            });
          }
        }
      }
    }
    setState(() {
      flag = true;
      _loadingStatus = false;
    });
    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => new NoteFromImage(uid: this.uid,title: this.title,amount: this.amount)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF5b5656),
      appBar: AppBar(
        backgroundColor: Color(0XFF7fcd91),
        title: Text('Pick an Image',
          style: TextStyle(
            color: Color(0XFF5b5656),
          ),
        ),
      ),
      body: _loadingStatus ? Center(
        child: CircularProgressIndicator(),
      ):
      
            SingleChildScrollView(
              child: Center(
          child: Column(
            children: <Widget>[
              !imageLoaded?Center(child: Icon(Icons.add_a_photo , size:300.0),):
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: (MediaQuery.of(context).size.height-300),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('From Gallery'),
                  onPressed: pickGalleryImage,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('From Camera'),
                  onPressed: pickCameraImage,
                ),
              ),
              AnimatedOpacity(
                opacity: imageLoaded ? 1.0 : 0.0,
                duration: Duration(milliseconds: 1500),
                child: RaisedButton(
                  child: Text('Scan Text'),
                  onPressed: readText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}