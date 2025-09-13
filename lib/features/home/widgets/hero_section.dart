import 'dart:math';
import 'package:binodfolio/core/utils/launch_utils.dart';
import 'package:flutter/material.dart';
import 'avatar.dart';
import 'package:binodfolio/core/responsive/sizes.dart';

class HeroSection extends StatelessWidget {
  final bool isDesktop;
  const HeroSection({required this.isDesktop, super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        final column = constraints.maxWidth < 900;
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
            borderRadius: BorderRadius.circular(16),
          ),
          padding: context.insetsAll(18),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            runSpacing: context.space(18),
            spacing: context.space(18),
            children: [
              SizedBox(
                width: column
                    ? constraints.maxWidth
                    : min(560, constraints.maxWidth * 0.55),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hi, I'm Binod 👋",
                        style: textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.w800, height: 1.1)),
                    SizedBox(height: context.space(10)),
                    Text(
                      'MSc Computer Science graduate with distinction, experienced in building and publishing mobile and web applications. Proven ability to deliver innovative, user-focused solutions, including launching apps to the Play Store and developing secure, scalable platforms. Eager to contribute technical expertise and problem-solving skills to a software development role.',
                      style: textTheme.titleMedium,
                    ),
                    SizedBox(height: context.space(16)),
                    Wrap(
                      spacing: context.space(10),
                      runSpacing: context.space(10),
                      children: [
                        OutlinedButton(
                          onPressed: () =>
                              launchUrlSafe('https://github.com/binodcoder'),
                          child: const Text('GitHub'),
                        ),
                        TextButton(
                          onPressed: () => launchUrlSafe(
                              'https://www.linkedin.com/in/binodcoder/'),
                          child: const Text('LinkedIn'),
                        ),
                        TextButton(
                          onPressed: () =>
                              launchUrlSafe('assets/CV_Binod_Bhandari.pdf'),
                          child: const Text('Download CV'),
                        ),
                      ],
                    ),
                    SizedBox(height: context.space(14)),
                    Wrap(
                      spacing: context.space(6),
                      runSpacing: context.space(6),
                      children: const [
                        _StatChip(label: '3+ yrs', sub: 'Experience'),
                        _StatChip(label: '5+ apps', sub: 'Delivered'),
                        _StatChip(label: '100+', sub: 'Users reached'),
                      ],
                    ),
                  ],
                ),
              ),
              Avatar(),
            ],
          ),
        );
      },
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String sub;
  const _StatChip({required this.label, required this.sub});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: context.insetsSymmetric(h: 10, v: 8),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(context.radius(12)),
        border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w800)),
          Text(sub, style: Theme.of(context).textTheme.labelMedium),
        ],
      ),
    );
  }
}
