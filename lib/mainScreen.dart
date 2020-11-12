import 'package:flutter/material.dart';
import 'package:image_classifier/buttons.dart';
import 'package:image_classifier/catdog/catDogClassifier.dart';
import 'package:image_classifier/flower/flowerClassifier.dart';
import 'package:image_classifier/fruits/fruitsClassifier.dart';
import 'package:image_classifier/gender/genderClassification.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'mainScreen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.deepOrangeAccent,
          title: Text('Image Classification', style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold
          ),),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        backgroundColor: Colors.black,
        body: Container(
          margin: EdgeInsets.only(top: 15),
          child: ListView(
            shrinkWrap: true,
            children: [
              ListContent(
                text: 'Cat and Dog',
                imagePath: 'assets/cat.png',
                onClick: () {
                  Navigator.pushNamed(context, CatDogClassifier.id);
                },
              ),
              ListContent(
                text: 'Gender Classification',
                imagePath: 'assets/malefemale.png',
                onClick: () {
                  Navigator.pushNamed(context, GenderClassification.id);
                },
              ),
              ListContent(
                text: 'Flower Classification',
                imagePath: 'assets/flowers.jpg',
                onClick: () {
                  Navigator.pushNamed(context, FlowerClassifier.id);
                },
              ),
              ListContent(
                text: 'Fruits Classification',
                imagePath: 'assets/fruits.png',
                onClick: () {
                  Navigator.pushNamed(context, FruitsClassifier.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
