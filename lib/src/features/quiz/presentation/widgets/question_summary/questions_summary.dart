import 'package:binodfolio/src/features/quiz/widgets/question_summary/question_identifier.dart';
import 'package:binodfolio/src/features/quiz/widgets/question_summary/summary_item.dart';
import 'package:flutter/material.dart';

import '../../models/result_summary.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary({
    super.key,
    required this.summaryData,
  });

  final List<ResultSummary> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: summaryData.map((data) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  QuestionIdentifier(
                    isCorrect: data.isCorrect,
                    questionIndex: data.questionIndex,
                  ),
                  SizedBox(width: 20),
                  SummaryItem(
                    question: data.question,
                    userAnswer: data.userAnswer,
                    correctAnswer: data.correctAnswer,
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
