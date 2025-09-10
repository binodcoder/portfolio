import 'package:flutter/widgets.dart';
import 'breakpoints.dart';

// Lightweight responsive sizing helpers for padding, spacing, icons, etc.
// Scales gently off a baseline phone width to keep UI consistent on devices.
extension ResponsiveSizes on BuildContext {
  // Baseline width for typical phone (iPhone 12/13 ~ 390)
  static const double _baselineWidth = 390.0;

  Size get _size => MediaQuery.sizeOf(this);
  Orientation get orientation => MediaQuery.orientationOf(this);

  // Use portrait width or landscape height as primary reference to avoid
  // over-scaling in landscape.
  double get _reference =>
      orientation == Orientation.portrait ? _size.width : _size.height;

  // Scale factor softly clamped to avoid extremes; slightly more generous on XL.
  double get _scale {
    final raw = _reference / _baselineWidth;
    final max = isXL ? 1.35 : (isDesktop ? 1.25 : 1.20);
    return raw.clamp(0.85, max);
  }

  // Scale a base value (e.g., 16) responsively.
  double rem(double base) => base * _scale;

  // Spacing helpers.
  double space(double base) => rem(base);
  double icon(double base) => rem(base);
  double radius(double base) => rem(base);

  // Insets helpers.
  EdgeInsets insetsAll(double base) => EdgeInsets.all(rem(base));
  EdgeInsets insetsSymmetric({double h = 0, double v = 0}) =>
      EdgeInsets.symmetric(horizontal: rem(h), vertical: rem(v));
  EdgeInsets insetsOnly({
    double left = 0,
    double right = 0,
    double top = 0,
    double bottom = 0,
  }) =>
      EdgeInsets.only(
        left: rem(left),
        right: rem(right),
        top: rem(top),
        bottom: rem(bottom),
      );
}
