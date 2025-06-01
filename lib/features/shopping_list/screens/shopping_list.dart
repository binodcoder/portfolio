import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_cv/features/shopping_list/data/categories.dart';
import 'package:my_cv/features/shopping_list/widgets/grocery_item.dart';
import 'package:my_cv/features/shopping_list/widgets/new_item.dart';
import 'package:http/http.dart' as http;

import '../models/grocery.dart';

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  List<Grocery> _groceryItems = [];
  late Future<List<Grocery>> _loadedItems;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadedItems = _loadItems();
  }

  Future<List<Grocery>> _loadItems() async {
    final url = Uri.https(
      'binodfolio-default-rtdb.firebaseio.com',
      'shopping-list.json',
    );

    final response = await http.get(url);

    if (response.statusCode >= 400) {
      throw Exception('Failed to fetch grocery items. please try again later.');
    }

    if (response.body == 'null') {
      return [];
    }

    final Map<String, dynamic> listData = json.decode(response.body);
    final List<Grocery> loadedItems = [];
    for (final item in listData.entries) {
      final category = categories.entries
          .firstWhere(
              (catItem) => catItem.value.title == item.value['category'])
          .value;
      loadedItems.add(
        Grocery(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category,
        ),
      );
    }
    return loadedItems;
  }

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

  void _removeItem(Grocery grocery) async {
    int index = _groceryItems.indexOf(grocery);
    setState(() {
      _groceryItems.remove(grocery);
    });
    final url = Uri.https('binodfolio-default-rtdb.firebaseio.com',
        'shopping-list/${grocery.id}.json');
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      // Optional : show error message.
      setState(() {
        _groceryItems.insert(index, grocery);
      });
    }

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
      body: FutureBuilder<List<Grocery>>(
          future: _loadedItems,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            if (snapshot.data!.isEmpty) {
              return Center(
                child: Text("no item added yet"),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (ctx, index) => Dismissible(
                background: Container(
                  color: Theme.of(context).colorScheme.error.withOpacity(0.55),
                  margin: EdgeInsets.symmetric(
                      horizontal:
                          Theme.of(context).cardTheme.margin!.horizontal),
                ),
                key: ValueKey(snapshot.data![index]),
                onDismissed: (direction) {
                  _removeItem(snapshot.data![index]);
                },
                child: GroceryItem(
                  name: snapshot.data![index].name,
                  color: snapshot.data![index].category.color,
                  quantity: snapshot.data![index].quantity,
                ),
              ),
            );
          }),
    );
  }
}
