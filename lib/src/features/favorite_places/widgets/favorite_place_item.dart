import 'package:flutter/material.dart';

class FavoritePlaceItem extends StatelessWidget {
  const FavoritePlaceItem({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(' ..'),
      title: Text(title),
    );
  }
}
