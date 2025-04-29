import 'package:flutter/material.dart';
import '../../common_widgets/app_bar.dart';
import 'widgets/gradient_container.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: GradientContainer(
        [
          Color.fromARGB(255, 214, 208, 226),
          Color.fromARGB(255, 158, 145, 177),
        ],
      ),
    );
  }
}
