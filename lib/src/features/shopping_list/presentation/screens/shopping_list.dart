import 'package:binodfolio/src/features/shopping_list/providers/shopping_list_provider.dart';
import 'package:binodfolio/src/features/shopping_list/widgets/grocery_item.dart';
import 'package:binodfolio/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ShoppingListScreen extends ConsumerWidget {
  const ShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groceriesValue = ref.watch(shoppingListProvider);

    Widget content = const Center(
      child: Text('no item added yet'),
    );

    content = groceriesValue.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text(e.toString())),
      data: (items) {
        if (items.isEmpty) {
          return const Center(child: Text('no item added yet'));
        }
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (ctx, index) => Dismissible(
            background: Container(
              color:
                  Theme.of(context).colorScheme.error.withValues(alpha: 0.55),
              margin: EdgeInsets.symmetric(
                horizontal: Theme.of(context).cardTheme.margin!.horizontal,
              ),
            ),
            key: ValueKey(items[index].id),
            onDismissed: (direction) async {
              try {
                await ref
                    .read(shoppingListProvider.notifier)
                    .removeItem(items[index]);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Grocery Item deleted')),
                );
              } catch (_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Delete failed. Restored item.')),
                );
              }
            },
            child: GroceryItem(
              name: items[index].name,
              color: items[index].category.color,
              quantity: items[index].quantity,
            ),
          ),
        );
      },
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
                    'Shopping List',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () =>
                        context.pushNamed(AppRoute.addShoppingItem.name),
                    icon: const Icon(Icons.add),
                    tooltip: 'Add Item',
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
