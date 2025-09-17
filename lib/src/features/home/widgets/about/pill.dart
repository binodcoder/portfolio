import 'package:binodfolio/core/responsive/sizes.dart';
import 'package:flutter/material.dart';

class Pill extends StatelessWidget {
  final String text;
  const Pill({required this.text});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: context.rem(10), vertical: context.rem(8)),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(context.radius(999)),
        border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.4)),
      ),
      child: Text(text),
    );
  }
}
