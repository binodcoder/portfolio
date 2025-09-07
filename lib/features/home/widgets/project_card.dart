import 'package:binodfolio/core/utils/launch_utils.dart';
import 'package:binodfolio/features/home/models/project.dart';
import 'package:flutter/material.dart';

class ProjectCard extends StatelessWidget {
  final Project p;
  const ProjectCard({required this.p});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      color: cs.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(p.title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Expanded(child: Text(p.description)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: p.tech.map((t) => Chip(label: Text(t))).toList(),
            ),
            const SizedBox(height: 12),
            Wrap(spacing: 8, children: [
              if (p.github != null)
                OutlinedButton(
                    onPressed: () => launchUrlSafe(p.github!),
                    child: const Text('GitHub')),
              if (p.live != null)
                FilledButton.tonal(
                    onPressed: () => launchUrlSafe(p.live!),
                    child: const Text('Live Demo')),
              if (p.playStore != null)
                FilledButton(
                    onPressed: () => launchUrlSafe(p.playStore!),
                    child: const Text('Play Store')),
            ])
          ],
        ),
      ),
    );
  }
}
