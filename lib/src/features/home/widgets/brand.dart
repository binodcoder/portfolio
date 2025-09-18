import 'package:flutter/material.dart';

class Brand extends StatelessWidget {
  const Brand({super.key});
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return ShaderMask(
      shaderCallback: (rect) => LinearGradient(
        colors: [cs.primary, cs.secondary, cs.tertiary],
      ).createShader(rect),
      blendMode: BlendMode.srcIn,
      child: Text(
        'binodcoder',
        style: t.titleLarge?.copyWith(
          fontWeight: FontWeight.w900,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}
