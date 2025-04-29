import 'package:flutter/material.dart';
import 'package:my_cv/features/quiz/screens/questions_screen.dart';
import 'package:my_cv/features/quiz/screens/results_screen.dart';
import 'package:my_cv/features/quiz/screens/start_screen.dart';
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
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 127, 70, 191),
              Color.fromARGB(255, 156, 97, 196),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: screenWidget,
      ),
    );
  }
}
