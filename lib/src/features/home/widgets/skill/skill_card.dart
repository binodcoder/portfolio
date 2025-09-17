import 'package:binodfolio/core/responsive/sizes.dart';
import 'package:flutter/material.dart';

class SkillCard extends StatelessWidget {
  final String title;
  final List<String> items;
  const SkillCard({required this.title, required this.items});

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