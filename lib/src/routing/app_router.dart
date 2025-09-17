import 'package:binodfolio/src/features/breathing/breathing.dart';
import 'package:binodfolio/src/features/expense_tracker/widgets/expenses.dart';
import 'package:binodfolio/src/features/favorite_places/screens/favorite_places.dart';
import 'package:binodfolio/src/features/home/home_page.dart';
import 'package:binodfolio/src/features/meal/screens/tabs.dart';
import 'package:binodfolio/src/features/pomodoro/pomodoro.dart';
import 'package:binodfolio/src/features/quiz/quiz.dart';
import 'package:binodfolio/src/features/shopping_list/screens/shopping_list.dart';
import 'package:binodfolio/src/features/todo/todo.dart';
import 'package:binodfolio/src/routing/not_found_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

enum AppRoute {
  home,
  breathing,
  expensesTracker,
  quiz,
  todo,
  pomodoro,
  meal,
  shoppingList,
  favoritePlaces,
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
        builder: (context, state) => HomePage(
          themeMode: ThemeMode.system,
          onThemeChanged: (ThemeMode themeMode) {
            // Implement theme change logic here
            return Future.value();
          },
        ),
        routes: [
          GoRoute(
            path: 'breathing',
            name: AppRoute.breathing.name,
            builder: (context, state) => BreathingApp(),
          ),
          GoRoute(
            path: 'expenses-tracker',
            name: AppRoute.expensesTracker.name,
            builder: (context, state) => Expenses(),
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
            path: 'meal',
            name: AppRoute.meal.name,
            builder: (context, state) => TabsScreen(),
          ),
          GoRoute(
            path: 'shopping-list',
            name: AppRoute.shoppingList.name,
            builder: (context, state) => ShoppingListScreen(),
          ),
          GoRoute(
            path: 'favorite-places',
            name: AppRoute.favoritePlaces.name,
            builder: (context, state) => FavoritePlaceScreen(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
}
