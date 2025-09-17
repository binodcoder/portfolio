import 'package:flutter/material.dart';
import 'package:binodfolio/core/responsive/sizes.dart';

class Footer extends StatelessWidget {
  const Footer();
  @override
  Widget build(BuildContext context) {
    final year = DateTime.now().year;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.rem(20)),
      child: Column(
        children: [
          // const Divider(height: 1),
          SizedBox(height: context.space(14)),
          Text(
            '© $year Binod Bhandari. All rights reserved.',
          ),
          SizedBox(height: context.space(8)),
        ],
      ),
    );
  }
}
