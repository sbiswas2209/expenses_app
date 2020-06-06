import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
class PickImage extends StatefulWidget {
  static final String tag = 'pick-image';
  @override
  _PickImageState createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  bool imageLoaded = false;
  PickedFile pickedImage;
  File image;
  final _picker = ImagePicker();
  Future pickGalleryImage() async {
    var tempStore = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      pickedImage = tempStore;
      image = File(pickedImage.path);
      imageLoaded = true;
    });
  }
  Future pickCameraImage() async {
    var tempStore = await _picker.getImage(source: ImageSource.camera);
    setState(() {
      imageLoaded = true;
      pickedImage = tempStore;
      image = File(pickedImage.path);
    });
  }

  Future readText() async {
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(image);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(ourImage);
    for(TextBlock block in readText.blocks){
      for(TextLine line in block.lines){
        for(TextElement word in line.elements){
          print(word.text);
        }
      }
    }
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
      body: Center(
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
            !imageLoaded ? SizedBox(height:10.0):
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text('Scan Text'),
                onPressed: readText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}