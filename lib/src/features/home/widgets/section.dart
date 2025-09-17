import 'package:flutter/material.dart';
import 'package:binodfolio/core/responsive/sizes.dart';

class Section extends StatefulWidget {
  final Widget child;
  const Section({super.key, required this.child});

  @override
  State<Section> createState() => _SectionState();
}

class _SectionState extends State<Section> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  )..forward();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait = context.orientation == Orientation.portrait;
    // Slightly larger vertical padding in portrait, tighter in landscape.
    final hPad = isPortrait ? 20.0 : 16.0;
    final vPad = isPortrait ? 28.0 : 22.0;
    return Container(
      padding: context.insetsSymmetric(h: hPad, v: vPad),
      constraints: const BoxConstraints(maxWidth: 1400),
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: AnimatedBuilder(
          animation: _c,
          builder: (context, child) => Opacity(
            opacity: Curves.easeOut.transform(_c.value),
            child: Transform.translate(
              offset: Offset(0, (1 - _c.value) * 18),
              child: child,
            ),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
