import 'package:binodfolio/src/core/responsive/sizes.dart';
import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const MenuItem({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      title: Text(label,
          style: t.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
      trailing:
          Icon(Icons.chevron_right, color: cs.outline, size: context.icon(20)),
      onTap: () {
        Navigator.of(context).pop();
        // Trigger after sheet closes for smoothness
        WidgetsBinding.instance.addPostFrameCallback((_) => onTap());
      },
    );
  }
}