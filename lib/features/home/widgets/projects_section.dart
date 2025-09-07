import 'package:binodfolio/features/home/data/projects.dart';
import 'package:binodfolio/features/home/widgets/project_card.dart';
import 'package:flutter/material.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection();
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Projects',
          style: t.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, c) {
            const spacing = 24.0;
            final isWide = c.maxWidth > 1000;
            final crossAxisCount = isWide ? 3 : (c.maxWidth > 700 ? 2 : 1);
            final itemWidth =
                (c.maxWidth - spacing * (crossAxisCount - 1)) / crossAxisCount;

            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: projects
                  .asMap()
                  .entries
                  .map(
                    (e) => SizedBox(
                      width: itemWidth,
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: 1),
                        duration:
                            Duration(milliseconds: 350 + (e.key % 6) * 60),
                        curve: Curves.easeOutCubic,
                        builder: (context, value, child) => Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0, (1 - value) * 20),
                            child: child,
                          ),
                        ),
                        child: SizedBox(
                          height: 280,
                          child: ProjectCard(p: e.value),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        )
      ],
    );
  }
}
