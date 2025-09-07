import 'package:binodfolio/features/favorite_places/screens/new_place.dart';
import 'package:binodfolio/features/favorite_places/widgets/favorite_place_item.dart';
import 'package:flutter/material.dart';

import '../models/place.dart';

class FavoritePlaceScreen extends StatefulWidget {
  @override
  State<FavoritePlaceScreen> createState() {
    return _FavoritePlaceScreenState();
  }
}

class _FavoritePlaceScreenState extends State<FavoritePlaceScreen> {
  List<Place> _places = [];

  void _addPlace() async {
    final place = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewPlaceScreen(),
      ),
    );
    setState(() {
      _places.add(place);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (_places.isEmpty) {
      content = Center(
        child: Text('No item available'),
      );
    }

    content = ListView.builder(
      itemCount: _places.length,
      itemBuilder: (ctx, index) => FavoritePlaceItem(
        title: _places[index].title,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Places'),
        actions: [
          IconButton(
            onPressed: _addPlace,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
