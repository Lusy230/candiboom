// main.dart
import 'package:candiboom/View/homepage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Candy Crush',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}