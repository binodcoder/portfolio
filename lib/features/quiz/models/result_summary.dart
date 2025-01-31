class ResultSummary {
  ResultSummary({
    required this.questionIndex,
    required this.question,
    required this.correctAnswer,
    required this.userAnswer,
    required this.isCorrect,
  });

  final int questionIndex;
  final String question;
  final String correctAnswer;
  final String userAnswer;
  final bool isCorrect;
}
