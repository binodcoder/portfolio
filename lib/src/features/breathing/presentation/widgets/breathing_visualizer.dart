import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/breathing_provider.dart';
import 'glow_circle.dart';

class BreathingVisualizer extends ConsumerWidget {
  final Animation<double> animation;
  const BreathingVisualizer({super.key, required this.animation});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        final controller = ref.read(breathingProvider.notifier);
        final info = controller.phaseInfo(animation.value);
        final scale = controller.scaleAt(animation.value);
        final label = controller.phaseLabel(info.phase);
        return Column(
          children: [
            GlowCircle(scale: scale),
            const SizedBox(height: 20),
            Text(
              '$label ${info.remaining.toString().padLeft(2, '0')}',
              style: theme.textTheme.titleLarge,
            ),
          ],
        );
      },
    );
  }
}
