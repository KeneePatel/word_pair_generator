import 'package:flutter/material.dart';
import './screens/random_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RandomWords(),
      theme: ThemeData(primaryColor: Colors.purple[300]),
      debugShowCheckedModeBanner: false,
    );
  }
}