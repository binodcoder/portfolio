import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        const spacing = 16.0;
        final isWide = c.maxWidth > 900;
        final crossAxisCount = isWide ? 3 : 1;
        final itemWidth = (c.maxWidth - spacing * (crossAxisCount - 1)) / crossAxisCount;

        final cards = const [
          _SkillCard(
            title: 'Mobile',
            items: [
              'Flutter',
              'Dart',
              'Riverpod',
              'BLoC',
              'Animations',
              'Accessibility'
            ],
          ),
          _SkillCard(
            title: 'Backend',
            items: ['Spring Boot', 'REST', 'JWT', 'MySQL', 'PostgreSQL'],
          ),
          _SkillCard(
            title: 'Cloud & DevOps',
            items: [
              'AWS',
              'CI/CD',
              'GitHub Actions',
              'Firebase',
              'Firestore'
            ],
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant.withOpacity(0.5)),
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
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: items.map((e) => Chip(label: Text(e))).toList(),
          )
        ],
      ),
    );
  }
}
