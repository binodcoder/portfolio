import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary({
    super.key,
    required this.summaryData,
  });

  final List<Map<String, Object>> summaryData;

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
                  Container(
                    width: 27,
                    height: 27,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: data['is_correct'] as bool ? Color.fromARGB(255, 0, 255, 0) : Color.fromARGB(255, 255, 0, 0),
                    ),
                    child: Text(
                      ((data['question_index'] as int) + 1).toString(),
                    ),
                    alignment: Alignment.center,
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['question'] as String,
                          style: GoogleFonts.lato(
                            color: Color.fromARGB(255, 237, 223, 252),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          data['user_answer'] as String,
                          style: TextStyle(color: Color.fromARGB(255, 191, 179, 179)),
                        ),
                        Text(
                          data['correct_answer'] as String,
                          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  )
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
