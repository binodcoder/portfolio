import 'package:flutter/material.dart';
import 'package:my_cv/features/favorite_places/models/place.dart';

class NewPlaceScreen extends StatefulWidget {
  NewPlaceScreen({super.key});

  @override
  State<NewPlaceScreen> createState() => _NewPlaceScreenState();
}

class _NewPlaceScreenState extends State<NewPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredPlaceName = '';

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.of(context).pop(
        Place(
          title: _enteredPlaceName,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Place'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              maxLength: 50,
              decoration: InputDecoration(
                label: Text(
                  'Place Name',
                ),
              ),
              onSaved: (value) {
                _enteredPlaceName = value!;
              },
            ),
            ElevatedButton(
              onPressed: _saveItem,
              child: Text('Add'),
            )
          ],
        ),
      ),
    );
  }
}
