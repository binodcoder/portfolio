import 'package:binodfolio/src/features/breathing/breathing.dart';
import 'package:binodfolio/src/features/expense_tracker/widgets/expenses.dart';
import 'package:binodfolio/src/features/expense_tracker/widgets/new_expense.dart';
import 'package:binodfolio/src/features/favorite_places/screens/favorite_places.dart';
import 'package:binodfolio/src/features/favorite_places/screens/new_place.dart';
import 'package:binodfolio/src/features/home/home_page.dart';
import 'package:binodfolio/src/features/meal/screens/categories.dart';
import 'package:binodfolio/src/features/meal/screens/meal_details.dart';
import 'package:binodfolio/src/features/meal/screens/category_meals_screen.dart';
import 'package:binodfolio/src/features/meal/screens/tabs.dart';
import 'package:binodfolio/src/features/pomodoro/pomodoro.dart';
import 'package:binodfolio/src/features/quiz/quiz.dart';
import 'package:binodfolio/src/features/shopping_list/screens/shopping_list.dart';
import 'package:binodfolio/src/features/shopping_list/widgets/new_item.dart';
import 'package:binodfolio/src/features/todo/todo.dart';
import 'package:binodfolio/src/routing/not_found_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'app_router.g.dart';

enum AppRoute {
  home,
  breathing,
  expensesTracker,
  newExpense,
  quiz,
  todo,
  pomodoro,
  tabs,
  categories,
  meals,
  mealDetails,
  shoppingList,
  addShoppingItem,
  favoritePlaces,
  addFavoritePlace,
}

@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: false,
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.home.name,
        builder: (context, state) => HomePage(),
        routes: [
          GoRoute(
            path: 'breathing',
            name: AppRoute.breathing.name,
            builder: (context, state) => BreathingApp(),
          ),
          GoRoute(
            path: 'expenses_tracker',
            name: AppRoute.expensesTracker.name,
            builder: (context, state) => Expenses(),
            routes: [
              GoRoute(
                path: "add_expense",
                name: AppRoute.newExpense.name,
                builder: (context, state) => const NewExpense(),
              )
            ],
          ),
          GoRoute(
            path: 'quiz',
            name: AppRoute.quiz.name,
            builder: (context, state) => Quiz(),
          ),
          GoRoute(
            path: 'todo',
            name: AppRoute.todo.name,
            builder: (context, state) => Todos(),
          ),
          GoRoute(
            path: 'pomodoro',
            name: AppRoute.pomodoro.name,
            builder: (context, state) => PomodoroApp(),
          ),
          GoRoute(
            path: 'tabs',
            name: AppRoute.tabs.name,
            builder: (context, state) => TabsScreen(),
            routes: [
              GoRoute(
                path: "categories",
                name: AppRoute.categories.name,
                builder: (context, state) => const CategoriesScreen(),
                routes: [
                  GoRoute(
                    path: "meals/:categoryId",
                    name: AppRoute.meals.name,
                    builder: (context, state) {
                      final categoryId = state.pathParameters['categoryId']!;
                      return CategoryMealsScreen(categoryId: categoryId);
                    },
                  )
                ],
              ),
              GoRoute(
                path: "meal/:mealId",
                name: AppRoute.mealDetails.name,
                builder: (context, state) {
                  final mealId = state.pathParameters['mealId']!;
                  return MealDetailScreen(mealId: mealId);
                },
              )
            ],
          ),
          GoRoute(
            path: 'shopping-list',
            name: AppRoute.shoppingList.name,
            builder: (context, state) => ShoppingListScreen(),
            routes: [
              GoRoute(
                path: 'add',
                name: AppRoute.addShoppingItem.name,
                builder: (context, state) => const NewItem(),
              ),
            ],
          ),
          GoRoute(
            path: 'favorite-places',
            name: AppRoute.favoritePlaces.name,
            builder: (context, state) => FavoritePlaceScreen(),
            routes: [
              GoRoute(
                path: 'add',
                name: AppRoute.addFavoritePlace.name,
                builder: (context, state) => const NewPlaceScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
}
