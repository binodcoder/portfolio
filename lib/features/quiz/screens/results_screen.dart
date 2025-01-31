import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/features/quiz/models/result_summary.dart';
import 'package:untitled/features/quiz/widgets/question_summary/questions_summary.dart';

import '../data/questions.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.chosenAnswers,
    required this.restartQuiz,
  });

  final List<String> chosenAnswers;
  final void Function() restartQuiz;

  List<ResultSummary> get summaryData {
    final List<ResultSummary> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      final questionIndex = i;
      final question = questions[i];
      final correctAnswer = question.answers[0];
      final userAnswer = chosenAnswers[i];
      final isCorrect = correctAnswer == userAnswer;

      summary.add(ResultSummary(
        questionIndex: questionIndex,
        question: question.text,
        correctAnswer: correctAnswer,
        userAnswer: userAnswer,
        isCorrect: isCorrect,
      ));
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final numTotalQuestions = questions.length;
    final numCorrectAnswers = summaryData.where((data) => data.isCorrect).length;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "You scored $numCorrectAnswers out of $numTotalQuestions",
            style: GoogleFonts.lato(
              color: Color.fromARGB(255, 237, 223, 252),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          QuestionsSummary(summaryData: summaryData),
          TextButton.icon(
            icon: Icon(
              Icons.refresh,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            onPressed: restartQuiz,
            label: const Text(
              "Restart Quiz",
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
        ],
      ),
    );
  }
}
