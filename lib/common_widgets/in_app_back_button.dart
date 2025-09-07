import 'package:flutter/material.dart';

/// A simple, reusable in-app back button that only shows
/// when the current Navigator stack can pop. Works on mobile and web.
class InAppBackButton extends StatelessWidget {
  const InAppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();
    if (!canPop) return const SizedBox.shrink();

    return IconButton(
      tooltip: 'Back',
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.of(context).maybePop(),
    );
  }
}

