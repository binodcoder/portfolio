import 'dart:math' as math;

import 'package:flutter/material.dart';

class GlowCircle extends StatelessWidget {
  final double scale; // 0..1
  const GlowCircle({super.key, required this.scale});

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
                  color.withValues(alpha: 0.35),
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

