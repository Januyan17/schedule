import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:schedule/datepicker.dart';

void main() {
  runApp(const MaterialApp(
    home: LandingScreen(),
  ));
}

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  File? imageFile;
  String? dropdownValue;

  _openGallery(BuildContext context) async {
    var picture =
        // ignore: invalid_use_of_visible_for_testing_member
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    // ignore: unnecessary_this
    this.setState(() {
      imageFile = picture as File?;
    });
    // Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture =
        // ignore: invalid_use_of_visible_for_testing_member
        await ImagePicker.platform.pickImage(source: ImageSource.camera);
    // ignore: unnecessary_this
    this.setState(() {
      imageFile = picture as File;
    });
    // Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a Choice "),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      _openGallery(context);
                      Navigator.of(context).pop();
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(context);
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget _decideImageView() {
    // ignore: unnecessary_null_comparison
    if (imageFile != null) {
      return Image.file(imageFile!);
    } else {
      return Text('Choose an image to show',
          style: TextStyle(fontSize: 18.0, color: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.only(top: 40.0),
          children: <Widget>[
            Container(
                width: 250,
                height: 250,
                alignment: Alignment.topCenter,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      imageFile == null
                          ? Text('No image selected.')
                          : Image.file(imageFile!,
                              width: 300, height: 200, fit: BoxFit.cover),
                    ])),
            SizedBox(height: 15.0),
            Container(
              child: Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(8.0)),
                  const Expanded(
                    child: Text('Tag People',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                        textAlign: TextAlign.left),
                  ),
                  Expanded(
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      alignment: Alignment.topRight,
                      icon: const Icon(Icons.arrow_drop_down),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['Red', 'Green', 'Blue']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            /////
            SizedBox(height: 15.0),
            Container(
              child: Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(8.0)),
                  const Expanded(
                    child: Text('Tag People',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                        textAlign: TextAlign.left),
                  ),
                  Expanded(
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      alignment: Alignment.topRight,
                      icon: const Icon(Icons.arrow_drop_down),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['Red', 'Green', 'Blue']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            //

            SizedBox(height: 15.0),
            Container(
              child: Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(10.0)),
                  const Expanded(
                    child: Text('Tag People',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                        textAlign: TextAlign.left),
                  ),
                  const Expanded(
                    child: Text('Tag People',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                        textAlign: TextAlign.end),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showChoiceDialog(context);
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.image),
      ),
    );
  }
}
