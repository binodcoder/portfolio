import 'package:flutter/material.dart';

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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
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
