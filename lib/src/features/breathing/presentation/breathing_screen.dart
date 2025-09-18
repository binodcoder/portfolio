import 'package:binodfolio/src/features/breathing/presentation/providers/breathing_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/breathing_visualizer.dart';
import 'widgets/breathing_controls.dart';
import 'widgets/pattern_selector.dart';

class BreathingScreen extends ConsumerStatefulWidget {
  const BreathingScreen({super.key});

  @override
  ConsumerState<BreathingScreen> createState() => _BreathingScreenState();
}

class _BreathingScreenState extends ConsumerState<BreathingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    final pattern = ref.read(breathingProvider).pattern;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: pattern.total),
    )..addStatusListener((status) {
        ref
            .read(breathingProvider.notifier)
            .onStatusChange(status, _controller);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(breathingProvider);
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary.withValues(alpha: 0.12),
              theme.colorScheme.secondary.withValues(alpha: 0.10),
              theme.colorScheme.tertiary.withValues(alpha: 0.08),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Just Breathe',
                  style: theme.textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                BreathingVisualizer(animation: _controller),
                const SizedBox(height: 24),
                BreathingControls(controller: _controller),
                const SizedBox(height: 16),
                PatternSelector(controller: _controller),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
