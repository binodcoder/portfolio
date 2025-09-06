import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  final Widget child;
  const Section({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 56),
      constraints: const BoxConstraints(maxWidth: 1400),
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: child,
      ),
    );
  }
}
