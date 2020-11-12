import 'package:flutter/material.dart';
import 'package:image_classifier/catdog/catDogClassifier.dart';
import 'package:image_classifier/flower/flowerClassifier.dart';
import 'package:image_classifier/fruits/fruitsClassifier.dart';
import 'package:image_classifier/mainScreen.dart';
import 'package:image_classifier/gender/genderClassification.dart';
import 'package:image_classifier/splashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Classification',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: SplashPage(),
      routes: {
        SplashPage.id:(context) => SplashPage(),
        MainScreen.id:(context) => MainScreen(),
        CatDogClassifier.id:(context) => CatDogClassifier(),
        FlowerClassifier.id:(context)=> FlowerClassifier(),
        FruitsClassifier.id:(context)=> FruitsClassifier(),
        GenderClassification.id:(context)=> GenderClassification()
      },
    );
  }
}
