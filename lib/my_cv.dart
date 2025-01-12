import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled/widgets/app_bar.dart';
import 'package:untitled/widgets/circle_avatar.dart';
import 'package:untitled/widgets/drawer/drawer.dart';
import 'package:untitled/widgets/gradient_container.dart';
import 'package:untitled/widgets/styled_text.dart';
import 'package:untitled/word_shortcut.dart';
import 'package:url_launcher/url_launcher.dart';
import 'message_card/message_card.dart';

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
