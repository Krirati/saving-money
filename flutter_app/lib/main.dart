import 'package:flutter/material.dart';
import 'package:savemoney/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Poppins',
        // primarySwatch: Colors.orangeAccent,
        primaryColor: Colors.orange[200],
        accentColor: Colors.orangeAccent,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
        canvasColor: Colors.transparent
      ),

      home: Home(),
    );
  }
}
