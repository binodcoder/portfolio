import 'package:binodfolio/features/home/widgets/about/about_item.dart';
import 'package:binodfolio/features/home/widgets/about/pill.dart';
import 'package:flutter/material.dart';
import 'package:binodfolio/core/responsive/sizes.dart';

class AboutSection extends StatelessWidget {
  const AboutSection();
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About Me',
            style: t.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
        SizedBox(height: context.space(10)),
        LayoutBuilder(
          builder: (context, c) {
            final twoCol = c.maxWidth > 860;
            final left = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: context.space(10)),
                Text(
                  "I build fast, reliable apps with a product mindset. Comfortable across the stack: Flutter on the front, Spring Boot on the back, with practical cloud know‑how.",
                  style: t.titleMedium,
                ),
                SizedBox(height: context.space(12)),
                Wrap(
                  spacing: context.space(6),
                  runSpacing: context.space(6),
                  children: const [
                    Pill(text: 'Performance first'),
                    Pill(text: 'Clean architecture'),
                    Pill(text: 'Accessibility'),
                  ],
                ),
                SizedBox(height: context.space(12)),
              ],
            );

            final right = Container(
              padding: context.insetsAll(14),
              decoration: BoxDecoration(
                // High-contrast background for mobile visibility
                gradient: LinearGradient(
                  colors: [
                    cs.surface.withValues(alpha: 0.98),
                    cs.surfaceContainerHighest.withValues(alpha: 0.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(context.radius(16)),
                border:
                    Border.all(color: cs.outlineVariant.withValues(alpha: 0.5)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: context.rem(14),
                    offset: Offset(0, context.rem(6)),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  AboutItem(
                      icon: Icons.place,
                      label: 'Based in',
                      value: 'UK / Remote'),
                  AboutItem(
                      icon: Icons.work_history,
                      label: 'Experience',
                      value: '3+ years'),
                  AboutItem(
                      icon: Icons.rocket_launch,
                      label: 'Focus',
                      value: 'Mobile + Backend'),
                  AboutItem(
                      icon: Icons.favorite,
                      label: 'Values',
                      value: 'Craft • Speed • Empathy'),
                ],
              ),
            );

            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    cs.primary.withValues(alpha: 0.06),
                    cs.secondary.withValues(alpha: 0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(context.radius(16)),
              ),
              padding: context.insetsAll(14),
              child: twoCol
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 3, child: left),
                        SizedBox(width: context.space(14)),
                        Expanded(flex: 2, child: right),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        left,
                        SizedBox(height: context.space(14)),
                        right,
                      ],
                    ),
            );
          },
        ),
      ],
    );
  }
}
