import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  Widget build(context) {
    final width = MediaQuery.of(context).size.width;
    final logoWidth = width < 400
        ? 180.0
        : width < 800
            ? 240.0
            : 300.0;
    final titleSize = width < 400
        ? 20.0
        : width < 800
            ? 24.0
            : 28.0;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/quiz/quiz-logo.png',
            width: logoWidth,
            color: Theme.of(context).colorScheme.onSurface,
            // Color.fromARGB(150, 255, 255, 255),
          ),
          // Opacity(
          //   opacity: 0.5,
          //   child: Image.asset(
          //     'assets/quiz/quiz-logo.png',
          //     width: 300,
          //   ),
          // ),
          SizedBox(height: 80),
          Text(
            "Learn Flutter the fun way !",
            style: GoogleFonts.lato(
              // color: Color.fromARGB(255, 237, 223, 252),
              fontSize: titleSize,
            ),
          ),
          const SizedBox(height: 30),
          OutlinedButton.icon(
            onPressed: startQuiz,
            style: OutlinedButton.styleFrom(
                // foregroundColor: Colors.white,
                ),
            icon: const Icon(Icons.arrow_right_alt),
            label: const Text(
              "Start Quiz",
            ),
          ),
        ],
      ),
    );
  }
}
