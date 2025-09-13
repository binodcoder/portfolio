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
          _SkillCard(
            title: 'Mobile',
            items: [
              'Flutter',
              'Dart',
              'Riverpod',
              'BLoC',
              'Animations',
            ],
          ),
          _SkillCard(
            title: 'Backend',
            items: ['Spring Boot', 'REST', 'JWT', 'MySQL', 'PostgreSQL'],
          ),
          _SkillCard(
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

class _SkillCard extends StatelessWidget {
  final String title;
  final List<String> items;
  const _SkillCard({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: context.insetsAll(14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(context.radius(12)),
        border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.w800),
          ),
          SizedBox(height: context.space(10)),
          Wrap(
            spacing: context.space(6),
            runSpacing: context.space(6),
            children: items.map((e) => Chip(label: Text(e))).toList(),
          )
        ],
      ),
    );
  }
}
