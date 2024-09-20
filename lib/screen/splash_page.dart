import 'dart:async';

import 'package:flutter/material.dart';

import 'home_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // Timer(Duration(seconds: 5), () {
    //   Navigator.of(context).pushNamed('/Homescreen');
    // });
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Homescreen()));
    });

    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(25),

              image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/img/04.jpeg'),
          )),
        ),
      ),
    );
  }
}
