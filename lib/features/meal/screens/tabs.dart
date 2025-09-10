import 'package:binodfolio/features/meal/providers/favorites_provider.dart';
import 'package:binodfolio/features/meal/screens/categories.dart';
import 'package:binodfolio/features/meal/screens/meals.dart';
import 'package:flutter/material.dart';
import 'package:binodfolio/common_widgets/in_app_back_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/filters_provider.dart';
import 'package:binodfolio/features/meal/widgets/filters_panel.dart';
import 'package:binodfolio/core/responsive/breakpoints.dart';

// const kInitialFilters = {
//   Filter.glutenFree: false,
//   Filter.lactoseFree: false,
//   Filter.vegetarian: false,
//   Filter.vegan: false,
// };

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    String activePageTitle = 'Categories';
    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
      );
      activePageTitle = 'Your Favorites';
    } else if (_selectedPageIndex == 2) {
      activePage = const FiltersPanel();
      activePageTitle = 'Setting';
    }
    final isMobile = context.isMobile; // < 600px

    Widget header = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          if (Navigator.of(context).canPop()) ...[
            const InAppBackButton(),
            const SizedBox(width: 8),
          ],
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
          onTap: _selectPage,
          currentIndex: _selectedPageIndex,
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
              selectedIndex: _selectedPageIndex,
              onDestinationSelected: _selectPage,
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
