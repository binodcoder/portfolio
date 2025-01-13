import 'package:flutter/material.dart';
import 'package:untitled/quiz/quiz_homepage.dart';
import 'my_cv.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuizHomepage(),
    );
  }
}
