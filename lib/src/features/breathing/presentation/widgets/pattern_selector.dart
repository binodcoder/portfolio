import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../breathing/data/patterns.dart';
import '../providers/breathing_provider.dart';
import '../../../breathing/domain/breath_pattern.dart';

class PatternSelector extends ConsumerWidget {
  final AnimationController controller;
  const PatternSelector({super.key, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pattern = ref.watch(breathingProvider.select((s) => s.pattern));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.self_improvement),
        const SizedBox(width: 8),
        DropdownButton<BreathPattern>(
          value: pattern,
          onChanged: (p) {
            if (p != null) {
              ref.read(breathingProvider.notifier).changePattern(p, controller);
            }
          },
          items: patterns
              .map((p) => DropdownMenuItem(
                    value: p,
                    child: Text(p.name),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
