import 'package:binodfolio/src/features/meal/presentation/providers/favorites_provider.dart';
import 'package:binodfolio/src/features/meal/presentation/screens/categories.dart';
import 'package:binodfolio/src/features/meal/presentation/screens/meals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:binodfolio/src/features/meal/presentation/widgets/filters_panel.dart';
import 'package:binodfolio/src/core/responsive/breakpoints.dart';
import 'package:binodfolio/src/features/meal/presentation/providers/tabs_provider.dart';

// const kInitialFilters = {
//   Filter.glutenFree: false,
//   Filter.lactoseFree: false,
//   Filter.vegetarian: false,
//   Filter.vegan: false,
// };

class TabsScreen extends ConsumerWidget {
  const TabsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(mealTabIndexProvider);

    void selectPage(int index) {
      ref.read(mealTabIndexProvider.notifier).state = index;
    }

    Widget activePage = CategoriesScreen();
    String activePageTitle = 'Categories';
    if (selectedIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsListProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
      );
      activePageTitle = 'Your Favorites';
    } else if (selectedIndex == 2) {
      activePage = const FiltersPanel();
      activePageTitle = 'Setting';
    }
    final isMobile = context.isMobile; // < 600px

    Widget header = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // if (Navigator.of(context).canPop()) ...[
          //   const InAppBackButton(),
          //   const SizedBox(width: 8),
          // ],
          Text(
            activePageTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
        ],
      ),
    );

    // Mobile: BottomNavigationBar
    if (isMobile) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              header,
              const Divider(height: 1),
              Expanded(child: activePage),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: selectPage,
          currentIndex: selectedIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.set_meal),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Setting',
            ),
          ],
        ),
      );
    }

    // Tablet/Desktop: Side navigation with NavigationRail
    final bool isExtended = context.screenWidth >= 900;
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            NavigationRail(
              selectedIndex: selectedIndex,
              onDestinationSelected: selectPage,
              // When `extended` is true, `labelType` must be null or none.
              labelType: isExtended ? null : NavigationRailLabelType.selected,
              extended: isExtended, // expand labels on wider screens
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.set_meal_outlined),
                  selectedIcon: Icon(Icons.set_meal),
                  label: Text('Categories'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.star_outline),
                  selectedIcon: Icon(Icons.star),
                  label: Text('Favorite'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings),
                  label: Text('Setting'),
                ),
              ],
            ),
            const VerticalDivider(width: 1),
            Expanded(child: activePage),
          ],
        ),
      ),
    );
  }
}
