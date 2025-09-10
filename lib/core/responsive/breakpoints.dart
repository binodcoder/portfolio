import 'package:flutter/widgets.dart';

// Generic breakpoints
const double kMobile = 600; // <600
const double kTablet = 900; // 600–899
const double kLaptop = 1200; // 900–1199
const double kDesktop = 1600; // 1200–1599

// App-specific breakpoints (centralized magic numbers)
const double kNavDesktop = 1100; // Desktop navbar threshold
const double kDialogSheetSwitch = 700; // Dialog vs bottom sheet for forms
const double kTwoPaneExpense = 800; // Split layout for Expense screen

extension ScreenBreakpoints on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;

  bool get isMobile => screenWidth < kMobile;
  bool get isTablet => screenWidth >= kMobile && screenWidth < kTablet;
  bool get isLaptop => screenWidth >= kTablet && screenWidth < kLaptop;
  bool get isDesktop => screenWidth >= kLaptop && screenWidth < kDesktop;
  bool get isXL => screenWidth >= kDesktop;

  // Convenience for top-level nav swap
  bool get isNavDesktop => screenWidth >= kNavDesktop;

  // Pick a value across breakpoints
  T responsiveValue<T>({
    required T mobile,
    T? tablet,
    T? laptop,
    T? desktop,
    T? xl,
  }) {
    if (isXL && xl != null) return xl;
    if (isDesktop && desktop != null) return desktop;
    if (isLaptop && laptop != null) return laptop;
    if (isTablet && tablet != null) return tablet;
    return mobile;
  }
}
