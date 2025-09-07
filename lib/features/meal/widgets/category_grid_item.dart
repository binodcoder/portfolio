import 'package:flutter/material.dart';
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
    final color = widget.category.color;
    final onCard = Colors.white.withOpacity(0.92);

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
              gradient: LinearGradient(
                colors: [
                  color.withOpacity(0.55),
                  color.withOpacity(0.35),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: _hovering
                  ? [
                      BoxShadow(
                        color: color.withOpacity(0.18),
                        blurRadius: 12,
                        spreadRadius: 0.3,
                        offset: const Offset(0, 6),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: color.withOpacity(0.10),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
            ),
            child: Stack(
              children: [
                // Soft gloss overlay
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 44,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(14),
                        topRight: Radius.circular(14),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.10),
                          Colors.white.withOpacity(0.02),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),
                // Content
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        _iconFor(widget.category.title),
                        size: 28,
                        color: onCard.withOpacity(0.8),
                      ),
                    ),
                    Text(
                      widget.category.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: onCard,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
