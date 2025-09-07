import 'package:flutter/material.dart';

class AppItem {
  final String title;
  final IconData icon;
  final WidgetBuilder builder;

  AppItem(this.title, this.icon, this.builder);
}
