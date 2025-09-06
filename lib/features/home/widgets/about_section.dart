import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection();
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About Me',
            style: t.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 12),
        Text(
          "I'm a Flutter developer based in the UK, with experience in Spring Boot backends, JWT auth, and deploying on AWS free tier. I built MeroKaam (job portal) and a fitness app with live sessions and walking routes.",
          style: t.titleMedium,
        ),
      ],
    );
  }
}
