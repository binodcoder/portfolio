import 'package:binodfolio/src/core/responsive/sizes.dart';
import 'package:flutter/material.dart';

class AboutItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const AboutItem(
      {super.key, required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.rem(6)),
      child: Row(
        children: [
          Container(
            width: context.rem(28),
            height: context.rem(28),
            decoration: BoxDecoration(
              color: cs.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(context.radius(8)),
            ),
            child: Icon(icon, size: context.icon(16), color: cs.primary),
          ),
          SizedBox(width: context.space(10)),
          Text('$label:',
              style: t.labelLarge?.copyWith(fontWeight: FontWeight.w700)),
          SizedBox(width: context.space(6)),
          Expanded(child: Text(value, style: t.labelLarge)),
        ],
      ),
    );
  }
}
