import 'package:flutter/material.dart';

class QuestionIdentifier extends StatelessWidget {
  const QuestionIdentifier({
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
        color: isCorrect
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.error,
      ),
      alignment: Alignment.center,
      child: Text(
        questionNumber.toString(),
        style: TextStyle(
          fontWeight: Theme.of(context).textTheme.bodyMedium!.fontWeight,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
