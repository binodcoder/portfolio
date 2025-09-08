import 'dart:math';
import 'package:binodfolio/core/utils/launch_utils.dart';
import 'package:flutter/material.dart';
import 'avatar.dart';

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
          padding: const EdgeInsets.all(20),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            runSpacing: 24,
            spacing: 24,
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
                    const SizedBox(height: 12),
                    Text(
                      'Flutter Engineer crafting fast, reliable apps. Strong backend chops with Spring Boot and a touch of AWS wizardry.',
                      style: textTheme.titleMedium,
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        OutlinedButton(
                          onPressed: () =>
                              launchUrlSafe('https://github.com/binodcoder'),
                          child: const Text('GitHub'),
                        ),
                        TextButton(
                          onPressed: () =>
                              launchUrlSafe('https://linkedin.com'),
                          child: const Text('LinkedIn'),
                        ),
                        TextButton(
                          onPressed: () =>
                              launchUrlSafe('assets/Binod_Bhandari_CV.pdf'),
                          child: const Text('Download CV'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
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
