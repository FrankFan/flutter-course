import 'package:flutter/material.dart';
import './RandomWordsState.dart';
import './IssueList.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to Flutter',
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      // home: new RandomWords(),
      home: new IssueList(title: 'flutter issue list'),
    );
  }
}
