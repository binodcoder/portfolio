import 'package:flutter/material.dart';

class GroceryItem extends StatelessWidget {
  const GroceryItem({
    super.key,
    required this.name,
    required this.color,
    required this.quantity,
  });

  final String name;
  final Color color;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(name),
        leading: Container(
          width: 24,
          height: 24,
          color: color,
        ),
        trailing: Text(
          quantity.toString(),
        ));
  }
}
