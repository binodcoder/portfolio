import 'dart:math' as math;

import 'package:flutter/material.dart';

class BreathPattern {
  final String name;
  final int inhale;
  final int hold1;
  final int exhale;
  final int hold2;

  const BreathPattern(
      this.name, this.inhale, this.hold1, this.exhale, this.hold2);

  int get total => inhale + hold1 + exhale + hold2;
}

const patterns = <BreathPattern>[
  BreathPattern('Box 4-4-4-4', 4, 4, 4, 4),
  BreathPattern('4-7-8 Relax', 4, 7, 8, 0),
  BreathPattern('Calm 5-5-5-5', 5, 5, 5, 5),
  BreathPattern('Energize 3-3-3-3', 3, 3, 3, 3),
];

enum BreathPhase { inhale, holdFull, exhale, holdEmpty }

class PhaseInfo {
  final BreathPhase phase;
  final double phaseT; // 0..1
  final int remaining; // seconds remaining in this phase (rounded)

  PhaseInfo(this.phase, this.phaseT, this.remaining);
}

class BreathingScreen extends StatefulWidget {
  const BreathingScreen({super.key});

  @override
  State<BreathingScreen> createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  BreathPattern _pattern = patterns.first;
  bool _running = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: _pattern.total),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed && _running) {
          _controller.forward(from: 0);
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _running = !_running;
      if (_running) {
        if (_controller.status == AnimationStatus.completed) {
          _controller.forward(from: 0);
        } else {
          _controller.forward();
        }
      } else {
        _controller.stop();
      }
    });
  }

  void _reset() {
    setState(() {
      _running = false;
      _controller.stop();
      _controller.value = 0;
    });
  }

  void _changePattern(BreathPattern next) {
    final wasRunning = _running;
    setState(() {
      _pattern = next;
      _running = false;
      _controller.stop();
    });
    _controller.dispose();
    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: _pattern.total))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed && _running) {
          _controller.forward(from: 0);
        }
      });
    if (wasRunning) {
      setState(() {
        _running = true;
        _controller.forward(from: 0);
      });
    }
  }

  // Compute phase and local progress within that phase from controller value
  PhaseInfo _phaseInfo(double t) {
    final total = _pattern.total.toDouble();
    final seconds = t * total; // 0..total

    final endIn = _pattern.inhale.toDouble();
    final endH1 = endIn + _pattern.hold1;
    final endEx = endH1 + _pattern.exhale;

    if (seconds < endIn) {
      final local = _pattern.inhale == 0 ? 1.0 : (seconds) / (_pattern.inhale);
      final remain = (_pattern.inhale - (seconds))
          .ceil()
          .clamp(0, _pattern.inhale)
          .toInt();
      return PhaseInfo(BreathPhase.inhale, local.clamp(0.0, 1.0), remain);
    } else if (seconds < endH1) {
      final elapsed = seconds - endIn;
      final remain =
          (_pattern.hold1 - elapsed).ceil().clamp(0, _pattern.hold1).toInt();
      return PhaseInfo(BreathPhase.holdFull, 0, remain);
    } else if (seconds < endEx) {
      final elapsed = seconds - endH1;
      final local = _pattern.exhale == 0 ? 1.0 : elapsed / _pattern.exhale;
      final remain =
          (_pattern.exhale - elapsed).ceil().clamp(0, _pattern.exhale).toInt();
      return PhaseInfo(BreathPhase.exhale, local.clamp(0.0, 1.0), remain);
    } else {
      final elapsed = seconds - endEx;
      final remain =
          (_pattern.hold2 - elapsed).ceil().clamp(0, _pattern.hold2).toInt();
      return PhaseInfo(BreathPhase.holdEmpty, 0, remain);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breathing'),
      ),
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
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    final info = _phaseInfo(_controller.value);

                    // Tween sequence for circle scale: 0->1 (inhale), hold, 1->0 (exhale), hold
                    final total = _pattern.total.toDouble();
                    final t = _controller.value;

                    double seg(double start, double len) => (t - start) / len;

                    final a = _pattern.inhale / total;
                    final b = _pattern.hold1 / total;
                    final c = _pattern.exhale / total;

                    double scale;
                    if (t < a) {
                      scale = Curves.easeInOut.transform(t / a);
                    } else if (t < a + b) {
                      scale = 1.0;
                    } else if (t < a + b + c) {
                      scale = 1 -
                          Curves.easeInOut
                              .transform(seg(a + b, c))
                              .clamp(0.0, 1.0);
                    } else {
                      scale = 0.0;
                    }

                    String label;
                    switch (info.phase) {
                      case BreathPhase.inhale:
                        label = 'Inhale';
                        break;
                      case BreathPhase.holdFull:
                        label = 'Hold';
                        break;
                      case BreathPhase.exhale:
                        label = 'Exhale';
                        break;
                      case BreathPhase.holdEmpty:
                        label = 'Hold';
                        break;
                    }

                    return Column(
                      children: [
                        _GlowCircle(scale: scale),
                        const SizedBox(height: 20),
                        Text(
                          '$label ${info.remaining.toString().padLeft(2, '0')}',
                          style: theme.textTheme.titleLarge,
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 24),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _toggle,
                      icon: Icon(_running ? Icons.pause : Icons.play_arrow),
                      label: Text(_running ? 'Pause' : 'Start'),
                    ),
                    OutlinedButton.icon(
                      onPressed: _reset,
                      icon: const Icon(Icons.restart_alt),
                      label: const Text('Reset'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.self_improvement),
                    const SizedBox(width: 8),
                    DropdownButton<BreathPattern>(
                      value: _pattern,
                      onChanged: (p) {
                        if (p != null) _changePattern(p);
                      },
                      items: patterns
                          .map((p) => DropdownMenuItem(
                                value: p,
                                child: Text(p.name),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GlowCircle extends StatelessWidget {
  final double scale; // 0..1
  const _GlowCircle({required this.scale});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    final size = 240.0 + (160.0 * scale);
    final blur = 28.0 + 24.0 * scale;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  color.withValues(alpha: 0.15),
                  color.withValues(alpha: 0.35)
                ],
                stops: const [0.6, 1.0],
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.45),
                  blurRadius: blur,
                  spreadRadius: 6,
                ),
              ],
            ),
          ),
          Transform.scale(
            scale: 0.65 + 0.35 * scale,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: SweepGradient(
                  colors: [
                    color.withValues(alpha: 0.85),
                    color.withValues(alpha: 0.35),
                    color.withValues(alpha: 0.85),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                  transform: GradientRotation(math.pi / 2),
                ),
              ),
            ),
          ),
          Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
        ],
      ),
    );
  }
}
