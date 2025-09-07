import 'package:binodfolio/core/utils/launch_utils.dart';
import 'package:flutter/material.dart';

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
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, c) {
            final twoCol = c.maxWidth > 860;
            final left = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: cs.primary.withOpacity(0.12),
                    border: Border.all(color: cs.primary.withOpacity(0.25)),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text('Flutter • Spring Boot • AWS',
                      style: t.labelMedium?.copyWith(
                          color: cs.primary, fontWeight: FontWeight.w700)),
                ),
                const SizedBox(height: 10),
                Text(
                  "I build fast, reliable apps with a product mindset. Comfortable across the stack: Flutter on the front, Spring Boot on the back, with practical cloud know‑how.",
                  style: t.titleMedium,
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: const [
                    _Pill(text: 'Performance first'),
                    _Pill(text: 'Clean architecture'),
                    _Pill(text: 'DX focused'),
                    _Pill(text: 'Accessibility'),
                  ],
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    FilledButton(
                      onPressed: () => launchUrlSafe(
                          'mailto:binodbhandari@gmail.com?subject=Project inquiry'),
                      child: const Text("Let's collaborate"),
                    ),
                    OutlinedButton(
                      onPressed: () =>
                          launchUrlSafe('https://github.com/binodcoder'),
                      child: const Text('GitHub'),
                    ),
                  ],
                ),
              ],
            );

            final right = Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                // High-contrast background for mobile visibility
                gradient: LinearGradient(
                  colors: [
                    cs.surface.withOpacity(0.98),
                    cs.surfaceContainerHighest.withOpacity(0.9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: cs.outlineVariant.withOpacity(0.5)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
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
                      value: '5+ years'),
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
                    cs.primary.withOpacity(0.06),
                    cs.secondary.withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: twoCol
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 3, child: left),
                        const SizedBox(width: 16),
                        Expanded(flex: 2, child: right),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        left,
                        const SizedBox(height: 16),
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
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: cs.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: cs.primary),
          ),
          const SizedBox(width: 10),
          Text('$label:',
              style: t.labelLarge?.copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(width: 6),
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: cs.outlineVariant.withOpacity(0.4)),
      ),
      child: Text(text),
    );
  }
}
