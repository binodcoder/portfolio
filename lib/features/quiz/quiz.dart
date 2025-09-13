import 'package:binodfolio/features/quiz/screens/questions_screen.dart';
import 'package:binodfolio/features/quiz/screens/results_screen.dart';
import 'package:binodfolio/features/quiz/screens/start_screen.dart';
import 'package:flutter/material.dart';

import 'data/questions.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});
  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> _selectedAnswers = [];
  var activeScreen = 'start-screen';

  void switchScreen() {
    setState(() {
      activeScreen = 'question-screen';
    });
  }

  void restartQuiz() {
    setState(() {
      _selectedAnswers = [];
      activeScreen = 'question-screen';
    });
  }

  void chooseAnswer(String answer) {
    _selectedAnswers.add(answer);

    if (_selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'results-screen';
      });
    }
  }

  @override
  Widget build(context) {
    final screenWidget = activeScreen == "start-screen"
        ? StartScreen(switchScreen)
        : activeScreen == "question-screen"
            ? QuestionsScreen(
                onSelectAnswer: chooseAnswer,
              )
            : ResultsScreen(
                chosenAnswers: _selectedAnswers,
                restartQuiz: restartQuiz,
              );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: screenWidget,
            ),
          ),
        ),
      ),
    );
  }
}
