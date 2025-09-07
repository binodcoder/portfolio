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
    return LayoutBuilder(
      builder: (context, constraints) {
        final column = constraints.maxWidth < 900;
        return Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          runSpacing: 24,
          spacing: 24,
          children: [
            SizedBox(
              width: column
                  ? constraints.maxWidth
                  : min(520, constraints.maxWidth * 0.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hi, I'm Binod 👋",
                      style: textTheme.displaySmall
                          ?.copyWith(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 12),
                  Text(
                    'Flutter Developer • Spring Boot • AWS (free tier wizard)...',
                    style: textTheme.titleMedium,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      FilledButton(
                        onPressed: () =>
                            launchUrlSafe('https://github.com/binodcoder'),
                        child: const Text('GitHub'),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton(
                        onPressed: () => launchUrlSafe('https://linkedin.com'),
                        child: const Text('LinkedIn'),
                      ),
                      const SizedBox(width: 12),
                      TextButton(
                        onPressed: () =>
                            launchUrlSafe('assets/Binod_Bhandari_CV.pdf'),
                        child: const Text('Download CV'),
                      ),
                      // TextButton(
                      //   onPressed: () => Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => BottomNavScaffold(),
                      //     ),
                      //   ),
                      //   child: const Text('More'),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
            Avatar(),
          ],
        );
      },
    );
  }
}
