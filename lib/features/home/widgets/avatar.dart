import 'dart:math';

import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = min(MediaQuery.of(context).size.width * 0.35, 260.0);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(.25),
            Theme.of(context).colorScheme.secondary.withOpacity(.25),
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
