import 'package:flutter/material.dart';

class Brand extends StatelessWidget {
  const Brand();
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Monogram badge
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [cs.primary, cs.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: cs.primary.withValues(alpha: 0.35),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            'BC',
            style: t.titleSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(width: 10),
        // Wordmark
        ShaderMask(
          shaderCallback: (rect) => LinearGradient(
            colors: [cs.primary, cs.secondary, cs.tertiary],
          ).createShader(rect),
          blendMode: BlendMode.srcIn,
          child: Text(
            'Binodcoder',
            style: t.titleLarge?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: 0.6,
            ),
          ),
        ),
      ],
    );
  }
}
