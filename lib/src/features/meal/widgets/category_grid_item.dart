import 'package:flutter/material.dart';
import 'package:binodfolio/src/core/responsive/sizes.dart';
import '../models/category.dart';

class CategoryGridItem extends StatefulWidget {
  const CategoryGridItem({
    super.key,
    required this.category,
    required this.onSelectCategory,
  });

  final Category category;
  final VoidCallback onSelectCategory;

  @override
  State<CategoryGridItem> createState() => _CategoryGridItemState();
}

class _CategoryGridItemState extends State<CategoryGridItem> {
  bool _hovering = false;

  IconData _iconFor(String title) {
    switch (title) {
      case 'Italian':
        return Icons.local_pizza;
      case 'Hamburgers':
        return Icons.lunch_dining;
      case 'German':
        return Icons.restaurant;
      case 'Breakfast':
        return Icons.free_breakfast;
      case 'Asian':
        return Icons.ramen_dining;
      case 'French':
        return Icons.bakery_dining;
      case 'Summer':
        return Icons.wb_sunny;
      case 'Quick & Easy':
        return Icons.flash_on;
      case 'Light & Lovely':
        return Icons.spa;
      case 'Exotic':
        return Icons.travel_explore;
      default:
        return Icons.restaurant_menu;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOut,
        scale: _hovering ? 1.015 : 1.0,
        child: InkWell(
          onTap: widget.onSelectCategory,
          borderRadius: BorderRadius.circular(14),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.transparent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: context.rem(40),
                  height: context.rem(40),
                  decoration: BoxDecoration(
                    color: cs.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(context.radius(8)),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    _iconFor(widget.category.title),
                    size: context.icon(20),
                    color: cs.primary,
                  ),
                ),
                SizedBox(height: context.space(8)),
                Text(
                  widget.category.title,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: cs.onSurface,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                        height: 1.1,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
