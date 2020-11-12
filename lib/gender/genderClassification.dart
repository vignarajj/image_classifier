import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_classifier/buttons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class GenderClassification extends StatefulWidget {
  static const String id = 'genderClassification';
  @override
  _GenderClassificationState createState() => _GenderClassificationState();
}

class _GenderClassificationState extends State<GenderClassification> {
  bool _loading = false;
  File _image;
  List _output;
  final picker = ImagePicker();

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

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);

    setState(() {
      _loading = false;
      _output = output;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: 'assets/gender/model_unquant.tflite',
      labels: 'assets/gender/labels.txt',
    );
  }

  @override
  void initState() {
    super.initState();
    _loading = true;
    loadModel().then((value) {
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.deepOrangeAccent,
          title: Text('Gender Classification', style: TextStyle(
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
          padding: EdgeInsets.symmetric(horizontal: 24),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Center(
                child: Text(
                  'Detect Gender',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 28),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: _loading
                    ? Container(
                  width: 250,
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/malefemale.png'),
                      SizedBox(height: 50),
                    ],
                  ),
                )
                    : Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 250,
                          child: Image.file(_image),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        _output != null
                            ? Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text('It\'s ${_output[0]['label']}',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0)),
                        )
                            : Container(),
                      ],
                    )),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 10),
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
      ),
    );
  }
}
