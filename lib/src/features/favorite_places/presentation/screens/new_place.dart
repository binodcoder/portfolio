import 'package:binodfolio/src/features/favorite_places/domain/place.dart';
import 'package:binodfolio/src/features/favorite_places/presentation/providers/favorite_places_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NewPlaceScreen extends ConsumerStatefulWidget {
  const NewPlaceScreen({super.key});

  @override
  ConsumerState<NewPlaceScreen> createState() => _NewPlaceScreenState();
}

class _NewPlaceScreenState extends ConsumerState<NewPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  var _enteredPlaceName = '';

  void _saveItem() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    ref.read(favoritePlacesProvider.notifier).addPlace(
          Place(title: _enteredPlaceName),
        );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text(
                    'New Place',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const Divider(height: 1),
              const SizedBox(height: 8),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      maxLength: 50,
                      decoration: const InputDecoration(
                        label: Text('Place Name'),
                      ),
                      onSaved: (value) => _enteredPlaceName = value!,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _saveItem,
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
