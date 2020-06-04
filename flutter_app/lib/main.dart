import 'package:flutter/material.dart';
import 'package:savemoney/constant.dart';
import 'package:savemoney/home.dart';

import 'database/dbHelper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper().initDb();
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
        primaryColor: Colors.orange[200],
        accentColor: Colors.orangeAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        canvasColor: Colors.transparent,
        scaffoldBackgroundColor: kBackgroundColor2
      ),

      home: Home(),
    );
  }
}
