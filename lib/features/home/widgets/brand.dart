import 'package:flutter/material.dart';
import 'package:binodfolio/core/responsive/sizes.dart';

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
          width: context.rem(36),
          height: context.rem(36),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(context.radius(10)),
            gradient: LinearGradient(
              colors: [cs.primary, cs.secondary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: cs.primary.withValues(alpha: 0.35),
                blurRadius: context.rem(16),
                offset: Offset(0, context.rem(6)),
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
        SizedBox(width: context.space(10)),
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
