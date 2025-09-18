import 'package:binodfolio/src/routing/app_router.dart';
import 'package:flutter/material.dart';

class AppItem {
  final String title;
  final IconData icon;
  final AppRoute appRoute;

  AppItem(this.title, this.icon, this.appRoute);
}
