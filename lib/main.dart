import 'package:flutter/material.dart';
import 'package:flutter_application_1/HomePageAdmin.dart';
import 'package:flutter_application_1/formaduan.dart';
import 'package:flutter_application_1/game.dart';
import 'package:flutter_application_1/homepage.dart';
import 'package:flutter_application_1/LandingPage.dart';
import 'package:flutter_application_1/quiz.dart';
import 'package:flutter_application_1/stage.dart';
import 'package:flutter_application_1/tampilangame.dart';
import 'SplashScreen.dart'; 
import 'login.dart'; 
import 'register.dart'; 
import 'LandingPage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:tampilangame(), 
    );
  }
}