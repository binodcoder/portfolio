import 'package:binodfolio/features/favorite_places/screens/new_place.dart';
import 'package:binodfolio/features/favorite_places/widgets/favorite_place_item.dart';
import 'package:flutter/material.dart';
import 'package:binodfolio/common_widgets/in_app_back_button.dart';

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  if (Navigator.of(context).canPop()) ...[
                    const InAppBackButton(),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    'Favorite Places',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: _addPlace,
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
