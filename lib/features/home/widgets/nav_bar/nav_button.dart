import 'package:flutter/material.dart';
import 'package:binodfolio/core/responsive/sizes.dart';

class NavButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const NavButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  State<NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<NavButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: context.insetsSymmetric(h: 10, v: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: t.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: _hovering ? cs.primary : t.titleSmall?.color,
                ),
              ),
              SizedBox(height: context.space(4)),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                height: context.rem(2),
                width: _hovering ? context.rem(18) : 0,
                decoration: BoxDecoration(
                  color: cs.primary,
                  borderRadius: BorderRadius.circular(context.radius(2)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
