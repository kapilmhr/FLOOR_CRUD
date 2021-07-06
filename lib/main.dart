import 'package:flutter/material.dart';
import 'package:flutter_floor/screens/HomeScreen.dart';


import 'database/PersonDatabase.dart';

void main() async{

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FLOOR CRUD',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

