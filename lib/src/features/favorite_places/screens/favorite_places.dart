import 'package:binodfolio/src/features/favorite_places/providers/favorite_places_provider.dart';
import 'package:binodfolio/src/features/favorite_places/widgets/favorite_place_item.dart';
import 'package:binodfolio/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoritePlaceScreen extends ConsumerWidget {
  const FavoritePlaceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final places = ref.watch(favoritePlacesProvider);

    final Widget content = places.isEmpty
        ? const Center(child: Text('No item available'))
        : ListView.builder(
            itemCount: places.length,
            itemBuilder: (ctx, index) => FavoritePlaceItem(
              title: places[index].title,
            ),
          );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text(
                    'Favorite Places',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => context.goNamed(
                      AppRoute.addFavoritePlace.name,
                    ),
                    icon: const Icon(Icons.add),
                    tooltip: 'Add Place',
                  ),
                ],
              ),
              const Divider(height: 1),
              const SizedBox(height: 8),
              Expanded(child: content),
            ],
          ),
        ),
      ),
    );
  }
}
