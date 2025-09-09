import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  const StyledText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Text(text, style: t.titleLarge?.copyWith(fontWeight: FontWeight.bold));
  }
}
