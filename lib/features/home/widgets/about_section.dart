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
                // Container(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                //   decoration: BoxDecoration(
                //     color: cs.primary.withValues(alpha: 0.12),
                //     border:
                //         Border.all(color: cs.primary.withValues(alpha: 0.25)),
                //     borderRadius: BorderRadius.circular(999),
                //   ),
                //   child: Text('Flutter • Spring Boot • AWS',
                //       style: t.labelMedium?.copyWith(
                //           color: cs.primary, fontWeight: FontWeight.w700)),
                // ),
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
                    _Pill(text: 'Performance first'),
                    _Pill(text: 'Clean architecture'),
                    _Pill(text: 'Accessibility'),
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
                  _AboutItem(
                      icon: Icons.place,
                      label: 'Based in',
                      value: 'UK / Remote'),
                  _AboutItem(
                      icon: Icons.work_history,
                      label: 'Experience',
                      value: '3+ years'),
                  _AboutItem(
                      icon: Icons.rocket_launch,
                      label: 'Focus',
                      value: 'Mobile + Backend'),
                  _AboutItem(
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

class _AboutItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _AboutItem(
      {required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.rem(6)),
      child: Row(
        children: [
          Container(
            width: context.rem(28),
            height: context.rem(28),
            decoration: BoxDecoration(
              color: cs.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(context.radius(8)),
            ),
            child: Icon(icon, size: context.icon(16), color: cs.primary),
          ),
          SizedBox(width: context.space(10)),
          Text('$label:',
              style: t.labelLarge?.copyWith(fontWeight: FontWeight.w700)),
          SizedBox(width: context.space(6)),
          Expanded(child: Text(value, style: t.labelLarge)),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String text;
  const _Pill({required this.text});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: context.rem(10), vertical: context.rem(8)),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(context.radius(999)),
        border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.4)),
      ),
      child: Text(text),
    );
  }
}
