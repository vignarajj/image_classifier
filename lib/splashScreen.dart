import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_classifier/mainScreen.dart';

class SplashPage extends StatefulWidget {
  static const String id = 'splashScreen';

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  navigateToLandingPage() async {
    var duration = new Duration(seconds: 5);
    return Timer(duration, nextPage);
  }

  void nextPage() {
    Navigator.pushNamedAndRemoveUntil(context, MainScreen.id, (route) => false);
  }

  @override
  void initState() {
    super.initState();
    navigateToLandingPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        Image.asset(
          'assets/splash_image.png',
          color: Colors.deepOrangeAccent,
          width: 200,
          height: 200,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Image Classification',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrangeAccent),
        )
          ],
        ),
      ),
    );
  }
}
