import 'package:flutter/material.dart';

class Brand extends StatelessWidget {
  const Brand();
  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context)
        .textTheme
        .titleLarge
        ?.copyWith(fontWeight: FontWeight.w700);
    return Text('Binod.dev', style: style);
  }
}
