import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:schedule/datepicker.dart';
import 'package:toggle_switch/toggle_switch.dart';

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
  String? dropdownValue2;
  bool isSwitched = false;

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
            title: const Text("Make a Choice "),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: const Text("Gallery"),
                    onTap: () {
                      _openGallery(context);
                      Navigator.of(context).pop();
                    },
                  ),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: const Text("Camera"),
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
      return const Text('Choose an image to show',
          style: TextStyle(fontSize: 18.0, color: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const Icon(
          Icons.cancel,
          color: Colors.blue,
        ),
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Text(
                "Next",
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.blue),
              ),
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.only(top: 40.0),
          children: <Widget>[
            Container(
                width: 250,
                height: 250,
                alignment: Alignment.topCenter,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _decideImageView(),
                    ])),
            const SizedBox(height: 15.0),
            TextFormField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15.0),
                hintText: 'Write Something Here',
              ),
            ),
            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                const Padding(padding: EdgeInsets.all(8.0)),
                const Expanded(
                  child: Text('Tag People',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      textAlign: TextAlign.left),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topRight,
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      alignment: Alignment.topRight,
                      icon: const Icon(Icons.arrow_drop_down),
                      // ignore: non_constant_identifier_names
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['Janu', 'Stelin', 'Sharmi']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            /////
            const SizedBox(height: 15.0),

            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                const Padding(padding: EdgeInsets.all(8.0)),
                const Expanded(
                  child: Text('Add Location',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      textAlign: TextAlign.left),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.topRight,
                    child: DropdownButton<String>(
                      value: dropdownValue2,
                      alignment: Alignment.topRight,
                      icon: const Icon(Icons.arrow_drop_down),
                      // ignore: non_constant_identifier_names
                      onChanged: (String? NewValue) {
                        setState(() {
                          dropdownValue2 = NewValue!;
                        });
                      },
                      items: <String>['Jaffna', 'Colombo', 'Galle']
                          .map<DropdownMenuItem<String>>((String value2) {
                        return DropdownMenuItem<String>(
                          value: value2,
                          child: Text(value2),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            //

            const SizedBox(height: 15.0),
            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                const Padding(padding: EdgeInsets.all(8.0)),
                const Expanded(
                  child: Text('Tag People',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      textAlign: TextAlign.left),
                ),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Text('Tag People',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                        textAlign: TextAlign.end),
                  ),
                ),
              ],
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
