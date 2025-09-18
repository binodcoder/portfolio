import 'package:binodfolio/src/features/home/data/projects.dart';
import 'package:binodfolio/src/features/home/presentation/widgets/project/project_card.dart';
import 'package:flutter/material.dart';
import 'package:binodfolio/src/core/responsive/sizes.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});
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
        SizedBox(height: context.space(14)),
        LayoutBuilder(
          builder: (context, c) {
            final spacing = context.space(18);
            final isWide = c.maxWidth > 1000;
            final crossAxisCount = isWide ? 3 : (c.maxWidth > 700 ? 2 : 1);
            final itemWidth =
                (c.maxWidth - spacing * (crossAxisCount - 1)) / crossAxisCount;
            final textScale = MediaQuery.textScaleFactorOf(context);
            final lockHeight = crossAxisCount >= 2 && textScale <= 1.10;
            final cardHeight = lockHeight ? context.rem(320) : null;

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
                        child: cardHeight != null
                            ? SizedBox(
                                height: cardHeight,
                                child: ProjectCard(p: e.value),
                              )
                            : ProjectCard(p: e.value),
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
