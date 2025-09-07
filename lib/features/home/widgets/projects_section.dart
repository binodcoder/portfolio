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
        Text('Projects',
            style: t.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, c) {
            final isWide = c.maxWidth > 1000;
            final gridCount = isWide ? 3 : (c.maxWidth > 700 ? 2 : 1);
            return GridView.builder(
              itemCount: projects.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridCount,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: isWide ? 1.25 : 1.05,
              ),
              itemBuilder: (context, i) => ProjectCard(p: projects[i]),
            );
          },
        )
      ],
    );
  }
}
