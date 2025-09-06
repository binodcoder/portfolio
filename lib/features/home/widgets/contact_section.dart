import 'package:flutter/material.dart';
import 'package:my_cv/core/utils/launch_utils.dart';

class ContactSection extends StatelessWidget {
  const ContactSection();
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Contact',
            style: t.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 12),
        Wrap(spacing: 12, runSpacing: 12, children: [
          FilledButton.icon(
              onPressed: () =>
                  launchUrlSafe('mailto:binodbhandari@example.com'),
              icon: const Icon(Icons.email),
              label: const Text('Email')),
          OutlinedButton.icon(
              onPressed: () => launchUrlSafe('https://github.com/binodcoder'),
              icon: const Icon(Icons.code),
              label: const Text('GitHub')),
          OutlinedButton.icon(
              onPressed: () => launchUrlSafe('https://www.linkedin.com'),
              icon: const Icon(Icons.person),
              label: const Text('LinkedIn')),
          TextButton(
              onPressed: () => launchUrlSafe('https://twitter.com'),
              child: const Text('X / Twitter')),
        ]),
      ],
    );
  }
}
