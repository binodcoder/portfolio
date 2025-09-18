import 'package:flutter/material.dart';
import 'package:binodfolio/src/core/responsive/sizes.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isPortrait = context.orientation == Orientation.portrait;
    // Scale avatar with orientation; clamp to keep it readable on phones.
    final raw = (isPortrait ? width * 0.45 : width * 0.30);
    final size = raw.clamp(120.0, 260.0);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withValues(alpha: .25),
            Theme.of(context).colorScheme.secondary.withValues(alpha: .25),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      alignment: Alignment.center,
      child: CircleAvatar(
        radius: size / 2 - 8,
        backgroundImage: const AssetImage(
            'assets/images/photo.jpg'), // put your photo at assets/avatar.png
      ),
    );
  }
}
