import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color_schemes.dart';

const _radius = 14.0;

final lightTheme = ThemeData(useMaterial3: true).copyWith(
  colorScheme: kColorScheme,
  appBarTheme: AppBarTheme().copyWith(
    backgroundColor: kColorScheme.onPrimaryContainer,
    foregroundColor: kColorScheme.primaryContainer,
  ),
  cardTheme: CardTheme(
    color: kColorScheme.surfaceContainerHighest,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radius)),
    margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
  iconTheme: const IconThemeData().copyWith(
    color: kColorScheme.onPrimaryContainer,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: kColorScheme.surfaceContainerHighest,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    isDense: true,
  ),
  // Keep default chip theme for broader SDK compatibility.
);

final darkTheme =
    ThemeData(brightness: Brightness.dark, useMaterial3: true).copyWith(
  colorScheme: kDarkColorScheme,
  cardTheme: CardTheme(
    color: kDarkColorScheme.surfaceContainerHighest,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radius)),
    margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: kDarkColorScheme.onPrimaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: kDarkColorScheme.surfaceContainerHighest,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    isDense: true,
  ),
  // Keep default chip theme for broader SDK compatibility.
);
