import 'package:binodfolio/core/utils/launch_utils.dart';
import 'package:binodfolio/features/home/models/project.dart';
import 'package:flutter/material.dart';
import 'package:binodfolio/core/responsive/sizes.dart';

class ProjectCard extends StatefulWidget {
  final Project p;
  const ProjectCard({super.key, required this.p});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;


    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedScale(
        scale: _hovering ? 1.01 : 1.0,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 160),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(16),
            border:
                Border.all(color: cs.outlineVariant.withValues(alpha: 0.35)),
            boxShadow: _hovering
                ? [
                    BoxShadow(
                      color: cs.primary.withValues(alpha: 0.18),
                      blurRadius: 24,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: widget.p.live != null
                ? () => launchUrlSafe(widget.p.live!)
                : (widget.p.github != null
                    ? () => launchUrlSafe(widget.p.github!)
                    : null),
            child: Padding(
              padding: context.insetsAll(14),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.p.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      SizedBox(height: context.space(6)),
                      Text(
                        widget.p.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  SizedBox(height: context.space(10)),
                  Wrap(
                    spacing: context.space(6),
                    runSpacing: context.space(6),
                    children: widget.p.tech
                        .map((t) => Chip(
                              label: Text(t),
                              padding: EdgeInsets.symmetric(
                                  horizontal: context.rem(6)),
                              visualDensity: VisualDensity.compact,
                            ))
                        .toList(),
                  ),
                  SizedBox(height: context.space(10)),
                  Wrap(
                    spacing: context.space(8),
                    children: [
                      if (widget.p.github != null)
                        OutlinedButton(
                          onPressed: () => launchUrlSafe(widget.p.github!),
                          child: const Text('GitHub'),
                        ),
                      if (widget.p.live != null)
                        FilledButton.tonal(
                          onPressed: () => launchUrlSafe(widget.p.live!),
                          child: const Text('Live Demo'),
                        ),
                      if (widget.p.playStore != null)
                        FilledButton(
                          onPressed: () => launchUrlSafe(widget.p.playStore!),
                          child: const Text('Play Store'),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Badge and related styles removed as requested
