import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:untitled/word_shortcut.dart';
import 'package:url_launcher/url_launcher.dart';

import 'common_widgets/app_bar.dart';
import 'common_widgets/drawer/drawer.dart';
import 'common_widgets/gradient_container.dart';

class MyCv extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: MyDrawer(),
      body: GradientContainer([
        Color.fromARGB(255, 214, 208, 226),
        Color.fromARGB(255, 158, 145, 177),
      ]),
    );
  }
}
