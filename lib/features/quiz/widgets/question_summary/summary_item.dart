import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/result_summary.dart';

class SummaryItem extends StatelessWidget {
  SummaryItem({
    super.key,
    required this.question,
    required this.userAnswer,
    required this.correctAnswer,
  });

  final String question;
  final String userAnswer;
  final String correctAnswer;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: GoogleFonts.lato(
              color: Color.fromARGB(255, 237, 223, 252),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            userAnswer,
            style: TextStyle(color: Color.fromARGB(255, 191, 179, 179)),
          ),
          Text(
            correctAnswer,
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
