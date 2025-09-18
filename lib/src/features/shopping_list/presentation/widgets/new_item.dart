import 'package:binodfolio/src/features/shopping_list/data/categories.dart';
import 'package:binodfolio/src/features/shopping_list/domain/category.dart';
import 'package:binodfolio/src/features/shopping_list/presentation/providers/shopping_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NewItem extends ConsumerStatefulWidget {
  const NewItem({super.key});

  @override
  ConsumerState<NewItem> createState() => _NewItemState();
}

class _NewItemState extends ConsumerState<NewItem> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredQuantity = 1;
  var _selectedCategory = categories[Categories.vegetables]!;
  var _isSending = false;

  Future<void> _saveItem() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() => _isSending = true);
    try {
      await ref.read(shoppingListProvider.notifier).addItem(
            name: _enteredName,
            quantity: _enteredQuantity,
            category: _selectedCategory,
          );
      if (!mounted) return;
      context.pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add item: $e')),
      );
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
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
                    'Add a new item',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const Divider(height: 1),
              const SizedBox(height: 8),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          maxLength: 50,
                          decoration: const InputDecoration(
                            label: Text('Name'),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.trim().length <= 1 ||
                                value.trim().length > 50) {
                              return 'Must be between 1 and 50 characters.';
                            }
                            return null;
                          },
                          onSaved: (value) => _enteredName = value!,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  label: Text('Quantity'),
                                ),
                                keyboardType: TextInputType.number,
                                initialValue: _enteredQuantity.toString(),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      int.tryParse(value) == null ||
                                      int.tryParse(value)! <= 0) {
                                    return 'Must be a valid, positive number.';
                                  }
                                  return null;
                                },
                                onSaved: (value) =>
                                    _enteredQuantity = int.parse(value!),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: DropdownButtonFormField<Classification>(
                                value: _selectedCategory,
                                items: [
                                  for (final category in categories.entries)
                                    DropdownMenuItem(
                                      value: category.value,
                                      child: Row(children: [
                                        Container(
                                          width: 16,
                                          height: 16,
                                          color: category.value.color,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(category.value.title),
                                      ]),
                                    ),
                                ],
                                onChanged: (value) {
                                  setState(() => _selectedCategory = value!);
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: _isSending
                                  ? null
                                  : () => _formKey.currentState!.reset(),
                              child: const Text('Reset'),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton(
                              onPressed: _isSending ? null : _saveItem,
                              child: _isSending
                                  ? const SizedBox(
                                      height: 16,
                                      width: 16,
                                      child: CircularProgressIndicator(),
                                    )
                                  : const Text('Add  Item'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
