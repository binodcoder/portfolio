import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/features/quiz/widgets/questions_summary.dart';

import '../data/questions.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.chosenAnswers,
    required this.restartQuiz,
  });

  final List<String> chosenAnswers;
  final void Function() restartQuiz;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      final questionIndex = i;
      final question = questions[i];
      final correctAnswer = question.answers[0];
      final userAnswer = chosenAnswers[i];
      final isCorrect = correctAnswer == userAnswer;

      summary.add({
        'question_index': questionIndex,
        'question': question.text,
        'correct_answer': correctAnswer,
        'user_answer': userAnswer,
        'is_correct': isCorrect,
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectAnswers = summaryData.where((data) => data['is_correct'] as bool).length;
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
