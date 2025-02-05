import 'package:flutter/material.dart';

class QuestionIdentifier extends StatelessWidget {
  QuestionIdentifier({
    super.key,
    required this.isCorrect,
    required this.questionIndex,
  });

  final bool isCorrect;
  final int questionIndex;

  @override
  Widget build(BuildContext context) {
    final questionNumber = questionIndex + 1;
    return Container(
      width: 27,
      height: 27,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: isCorrect ? Color.fromARGB(255, 0, 255, 0) : Color.fromARGB(255, 255, 0, 0),
      ),
      child: Text(
        questionNumber.toString(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 22, 2, 56),
        ),
      ),
      alignment: Alignment.center,
    );
  }
}
