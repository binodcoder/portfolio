import 'package:binodfolio/src/features/home/domain/app_item.dart';
import 'package:binodfolio/src/features/home/presentation/widgets/app_section/app_card.dart';
import 'package:binodfolio/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:binodfolio/src/core/responsive/sizes.dart';
import 'package:go_router/go_router.dart';

class AppsSection extends StatelessWidget {
  AppsSection({super.key});

  final List<AppItem> items = [
    AppItem('Expenses', Icons.attach_money, AppRoute.expensesTracker),
    AppItem('Quiz', Icons.quiz, AppRoute.quiz),
    AppItem('Todo', Icons.task, AppRoute.todo),
    AppItem('Pomodoro', Icons.timer, AppRoute.pomodoro),
    AppItem('Breathing', Icons.self_improvement, AppRoute.breathing),
    AppItem('Meal', Icons.set_meal, AppRoute.tabs),
    AppItem('Shopping List', Icons.shop, AppRoute.shoppingList),
    AppItem('Favorite Places', Icons.favorite, AppRoute.favoritePlaces),
  ];
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Apps',
            style: t.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
        SizedBox(height: context.space(10)),
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            // Keep mobile at 2 columns; scale up columns for wider screens.
            int crossAxisCount = 2; // default for mobile
            if (width >= 600 && width < 900) {
              crossAxisCount = 3;
            } else if (width >= 900 && width < 1200) {
              crossAxisCount = 4;
            } else if (width >= 1200) {
              crossAxisCount = 5;
            }

            final spacing = context.space(16);
            final itemWidth =
                (width - spacing * (crossAxisCount - 1)) / crossAxisCount;
            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: items.map((item) {
                return SizedBox(
                  width: itemWidth,
                  child: AppCard(
                    icon: item.icon,
                    title: item.title,
                    onTap: () {
                      context.goNamed(item.appRoute.name);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (_) => item.builder(context)),
                      // );
                    },
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
