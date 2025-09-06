import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection();
  @override
  Widget build(BuildContext context) {
    final chips = [
      'Flutter',
      'Dart',
      'BLoC',
      'Riverpod',
      'Spring Boot',
      'REST API',
      'JWT',
      'AES-256',
      'Firebase',
      'Firestore',
      'CI/CD',
      'GitHub Actions',
      'AWS',
      'RDS',
      'VPC',
      'MySQL',
      'PostgreSQL',
      'Unit/Widget Tests'
    ];
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: chips.map((c) => Chip(label: Text(c))).toList(),
    );
  }
}
