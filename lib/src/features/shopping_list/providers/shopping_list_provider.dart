import 'dart:convert';

import 'package:binodfolio/src/features/shopping_list/data/categories.dart';
import 'package:binodfolio/src/features/shopping_list/models/grocery.dart';
import 'package:binodfolio/src/features/shopping_list/models/category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ShoppingListNotifier extends AsyncNotifier<List<Grocery>> {
  @override
  Future<List<Grocery>> build() async {
    return await _loadItems();
  }

  Future<List<Grocery>> _loadItems() async {
    final url = Uri.https(
      'binodfolio-default-rtdb.firebaseio.com',
      'shopping-list.json',
    );

    final response = await http.get(url);

    if (response.statusCode >= 400) {
      throw Exception('Failed to fetch data');
    }

    if (response.body == 'null') {
      return [];
    }

    final Map<String, dynamic> listData = json.decode(response.body);
    final List<Grocery> loadedItems = [];
    for (final item in listData.entries) {
      final category = categories.entries
          .firstWhere(
            (catItem) => catItem.value.title == item.value['category'],
          )
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

  Future<void> addItem({
    required String name,
    required int quantity,
    required Classification category,
  }) async {
    final url = Uri.https(
      'binodfolio-default-rtdb.firebaseio.com',
      'shopping-list.json',
    );

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {
          'name': name,
          'quantity': quantity,
          'category': category.title,
        },
      ),
    );

    if (response.statusCode >= 400) {
      throw Exception('Failed to add item');
    }

    final Map<String, dynamic> resData = json.decode(response.body);
    final newItem = Grocery(
      id: resData['name'],
      name: name,
      quantity: quantity,
      category: category,
    );

    final current = state.value ?? [];
    state = AsyncValue.data([...current, newItem]);
  }

  Future<void> removeItem(Grocery grocery) async {
    final prev = state.value ?? [];
    final index = prev.indexWhere((g) => g.id == grocery.id);
    final optimistic = [...prev]..removeAt(index);
    state = AsyncValue.data(optimistic);

    final url = Uri.https(
      'binodfolio-default-rtdb.firebaseio.com',
      'shopping-list/${grocery.id}.json',
    );
    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      // revert
      state = AsyncValue.data(prev);
      throw Exception('Failed to delete item');
    }
  }
}

final shoppingListProvider = AsyncNotifierProvider<ShoppingListNotifier, List<Grocery>>(
  ShoppingListNotifier.new,
);

