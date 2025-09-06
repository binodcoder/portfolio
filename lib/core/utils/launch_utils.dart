import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchUrlSafe(String url) async {
  final uri = Uri.parse(url);
  if (!await launchUrl(uri, webOnlyWindowName: '_blank')) {
    debugPrint('Could not launch $url');
  }
}
