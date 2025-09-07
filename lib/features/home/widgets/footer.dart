import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer();
  @override
  Widget build(BuildContext context) {
    final year = DateTime.now().year;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          const Divider(height: 1),
          const SizedBox(height: 16),
          Text('© $year Binod Bhandari'),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
