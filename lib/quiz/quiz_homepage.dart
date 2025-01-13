import 'package:flutter/material.dart';
import 'package:untitled/widgets/styled_text.dart';

class QuizHomepage extends StatelessWidget {
  const QuizHomepage({super.key});

  final startAlignment = Alignment.topLeft;
  final endAlignment = Alignment.bottomRight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 108, 68, 192),
              Color.fromARGB(255, 118, 68, 195),
            ],
            begin: startAlignment,
            end: endAlignment,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              'assets/quiz/quiz-logo.png',
              width: 200,
              height: 200,
            ),
            StyledText("Learn Flutter the fun way !"),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "Start Quiz",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
