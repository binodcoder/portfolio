import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/breathing_provider.dart';

class BreathingControls extends ConsumerWidget {
  final AnimationController controller;
  const BreathingControls({super.key, required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final running = ref.watch(breathingProvider.select((s) => s.running));
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 12,
      runSpacing: 12,
      children: [
        ElevatedButton.icon(
          onPressed: () =>
              ref.read(breathingProvider.notifier).toggle(controller),
          icon: Icon(running ? Icons.pause : Icons.play_arrow),
          label: Text(running ? 'Pause' : 'Start'),
        ),
        OutlinedButton.icon(
          onPressed: () =>
              ref.read(breathingProvider.notifier).reset(controller),
          icon: const Icon(Icons.restart_alt),
          label: const Text('Reset'),
        ),
      ],
    );
  }
}
