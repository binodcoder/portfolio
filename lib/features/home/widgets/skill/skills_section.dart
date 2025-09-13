import 'package:binodfolio/features/home/widgets/skill/skill_card.dart';
import 'package:flutter/material.dart';
import 'package:binodfolio/core/responsive/sizes.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final spacing = context.space(18);
        final isWide = c.maxWidth > 900;
        final crossAxisCount = isWide ? 3 : 1;
        final itemWidth =
            (c.maxWidth - spacing * (crossAxisCount - 1)) / crossAxisCount;

        final cards = const [
          SkillCard(
            title: 'Mobile',
            items: [
              'Flutter',
              'Dart',
              'Riverpod',
              'BLoC',
              'Animations',
            ],
          ),
          SkillCard(
            title: 'Backend',
            items: ['Spring Boot', 'REST', 'JWT', 'MySQL', 'PostgreSQL'],
          ),
          SkillCard(
            title: 'Cloud & DevOps',
            items: ['AWS', 'CI/CD', 'GitHub Actions', 'Firebase', 'Firestore'],
          ),
        ];

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: cards
              .map((card) => SizedBox(width: itemWidth, child: card))
              .toList(),
        );
      },
    );
  }
}
