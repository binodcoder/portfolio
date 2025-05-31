import 'package:flutter/material.dart';
import 'package:my_cv/features/shopping_list/widgets/grocery_item.dart';
import 'package:my_cv/features/shopping_list/widgets/new_item.dart';

import '../models/grocery.dart';

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  final List<Grocery> _groceryItems = [];

  void _addItem() async {
    final newItem = await Navigator.of(context).push<Grocery>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );

    if (newItem == null) {
      return;
    }

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _removeItem(Grocery grocery) {
    int index = _groceryItems.indexOf(grocery);
    setState(() {
      _groceryItems.remove(grocery);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Grocery Item deleted'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _groceryItems.insert(index, grocery);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Text("no item added yet"),
    );

    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (ctx, index) => Dismissible(
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.55),
            margin: EdgeInsets.symmetric(
                horizontal: Theme.of(context).cardTheme.margin!.horizontal),
          ),
          key: ValueKey(_groceryItems[index]),
          onDismissed: (direction) {
            _removeItem(_groceryItems[index]);
          },
          child: GroceryItem(
            name: _groceryItems[index].name,
            color: _groceryItems[index].category.color,
            quantity: _groceryItems[index].quantity,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping List'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: content,
    );
  }
}
