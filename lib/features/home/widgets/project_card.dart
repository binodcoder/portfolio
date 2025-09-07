import 'package:binodfolio/core/utils/launch_utils.dart';
import 'package:binodfolio/features/home/models/project.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

    _BadgeStyle _styleFor(String title) {
      final t = title.toLowerCase();
      if (t.contains('fitness')) {
        return _BadgeStyle(Icons.fitness_center, Colors.pink);
      }
      if (t.contains('blog')) {
        return _BadgeStyle(Icons.article, Colors.indigo);
      }
      if (t.contains('pos') || t.contains('restaurant')) {
        return _BadgeStyle(Icons.point_of_sale, Colors.deepOrange);
      }
      if (t.contains('dental') || t.contains('clinic')) {
        return _BadgeStyle(Icons.medical_services, Colors.teal);
      }
      if (t.contains('account') || t.contains('accounts')) {
        return _BadgeStyle(Icons.account_balance, Colors.green);
      }
      if (t.contains('job') || t.contains('portal') || t.contains('merokaam')) {
        return _BadgeStyle(Icons.work, cs.primary);
      }
      return _BadgeStyle(Icons.apps, cs.primary);
    }

    final badge = _styleFor(widget.p.title);

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
            color: cs.surfaceContainerLow,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: cs.outlineVariant.withOpacity(0.35)),
            boxShadow: _hovering
                ? [
                    BoxShadow(
                      color: cs.primary.withOpacity(0.18),
                      blurRadius: 24,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Badge(color: badge.color, icon: badge.icon),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
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
                            const SizedBox(height: 6),
                            Text(
                              widget.p.description,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.p.tech
                        .map((t) => Chip(
                              label: Text(t),
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              visualDensity: VisualDensity.compact,
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: [
                      if (widget.p.github != null)
                        OutlinedButton.icon(
                          onPressed: () => launchUrlSafe(widget.p.github!),
                          icon: const FaIcon(FontAwesomeIcons.github, size: 16),
                          label: const Text('GitHub'),
                        ),
                      if (widget.p.live != null)
                        FilledButton.tonalIcon(
                          onPressed: () => launchUrlSafe(widget.p.live!),
                          icon: const Icon(Icons.open_in_new, size: 18),
                          label: const Text('Live Demo'),
                        ),
                      if (widget.p.playStore != null)
                        FilledButton.icon(
                          onPressed: () => launchUrlSafe(widget.p.playStore!),
                          icon: const Icon(Icons.shop_2, size: 18),
                          label: const Text('Play Store'),
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

class _Badge extends StatelessWidget {
  final Color color;
  final IconData icon;
  const _Badge({required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.75),
            color.withOpacity(0.45),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.18),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Icon(icon, color: Colors.white),
    );
  }
}

class _BadgeStyle {
  final IconData icon;
  final Color color;
  const _BadgeStyle(this.icon, this.color);
}
