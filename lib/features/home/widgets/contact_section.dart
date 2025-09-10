import 'package:binodfolio/core/utils/launch_utils.dart';
import 'package:flutter/material.dart';
import 'package:binodfolio/core/responsive/sizes.dart';

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
        SizedBox(height: context.space(10)),
        Wrap(spacing: context.space(10), runSpacing: context.space(10), children: [
          FilledButton.icon(
              onPressed: () =>
                  launchUrlSafe('mailto:binodbhandari@example.com'),
              icon: Icon(Icons.email, size: context.icon(20)),
              label: const Text('Email')),
          OutlinedButton.icon(
              onPressed: () => launchUrlSafe('https://github.com/binodcoder'),
              icon: Icon(Icons.code, size: context.icon(20)),
              label: const Text('GitHub')),
          OutlinedButton.icon(
              onPressed: () => launchUrlSafe('https://www.linkedin.com'),
              icon: Icon(Icons.person, size: context.icon(20)),
              label: const Text('LinkedIn')),
          TextButton(
              onPressed: () => launchUrlSafe('https://twitter.com'),
              child: const Text('X / Twitter')),
        ]),
      ],
    );
  }
}
