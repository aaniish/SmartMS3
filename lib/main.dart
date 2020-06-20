import 'package:flutter/material.dart';
import 'dart:convert' show utf8;
import 'package:smart_ms3/pages/navigation/bottom_navigation.dart';
import 'package:flutter/services.dart' ;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'HelveticaNeue'
      ),
      home: BottomBarNavigation(),
      
    );
  }
}

