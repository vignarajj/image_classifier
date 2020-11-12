import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_classifier/buttons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class FruitsClassifier extends StatefulWidget {
  static const String id = 'fruitsClassifier';
  @override
  _FruitsClassifierState createState() => _FruitsClassifierState();
}

class _FruitsClassifierState extends State<FruitsClassifier> {
  final picker = ImagePicker();
  File _image;
  bool _loading = false;
  List _output;

  pickImage() async {
    var image = await picker.getImage(source: ImageSource.camera);

    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  pickGalleryImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);

    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  @override
  void initState() {
    super.initState();
    _loading = true;
    loadModel().then((value) {
      // setState(() {});
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 130,
      // threshold: 0.5,
    );

    setState(() {
      _loading = false;
      _output = output;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: 'assets/fruits/model.tflite',
      labels: 'assets/fruits/labels.txt',
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.deepOrangeAccent,
          title: Text('Fruits Classification', style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold
          ),),
          iconTheme: IconThemeData(
              color: Colors.white
          ),
          automaticallyImplyLeading: true,
          centerTitle: false,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.004, 1],
              colors: [
                Color(0xFF000000),
                Color(0xFF3d3d3d),
              ],
            ),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: <Widget>[
                SizedBox(height: 30),
                Text(
                  'Fruits Classification',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 28),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10),
                      Container(
                        width: 200,
                        // height: 250,
                        child: Center(
                          child: _loading
                              ? Container(
                            width: 150,
                            child: Column(
                              children: <Widget>[
                                Container(
                                    height: 180,
                                    child: Image.asset(
                                      'assets/fruits.png',
                                      scale: 0.6,
                                    )),
                                SizedBox(
                                  height: 60,
                                ),
                              ],
                            ),
                          )
                              : Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 150,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      _image,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                _output != null
                                    ? Text(
                                  'Prediction is: ${_output[0]['label']}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0),
                                )
                                    : Container(),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: <Widget>[
                            AppButton(
                              onClick: pickImage,
                              btnText: 'From Camera',
                            ),
                            SizedBox(height: 15),
                            AppButton(
                              onClick: pickGalleryImage,
                              btnText: 'From Gallery',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
