import 'package:binodfolio/common_widgets/styled_text.dart';
import 'package:binodfolio/features/home/widgets/media/youtube_player.dart';
import 'package:binodfolio/features/home/widgets/media/youtube_player_web.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:url_launcher/url_launcher.dart';
import '../../../common_widgets/circle_avatar.dart';
import 'dice_roller.dart';
import 'message_card.dart';
import 'package:flutter/foundation.dart';

class GradientContainer extends StatelessWidget {
  GradientContainer(this.colors, {super.key});

  GradientContainer.purple({super.key})
      : colors = [Colors.deepPurple, Colors.indigo];

  final startAlignment = Alignment.topLeft;
  final endAlignment = Alignment.bottomRight;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          // Color.fromARGB(255, 26, 2, 80),
          // Color.fromARGB(255, 45, 7, 98),
          begin: startAlignment,
          end: endAlignment,
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Container(
              //   width: 50,
              //   height: 50,
              //   child: SvgPicture.asset(
              //     'assets/images/logo_setting.svg',
              //     semanticsLabel: 'Dart Logo',
              //   ),
              // ),
              // Container(
              //   width: 50,
              //   height: 50,
              //   child: Image(
              //     image: AssetImage('assets/images/education.png'),
              //   ),
              // ),
              Card(
                elevation: 2.0,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 30.2, horizontal: 20.0),
                  child: Column(
                    children: [
                      CustomCircleAvatar(
                        radius: 60.0,
                        imagePath: "assets/images/photo.jpg",
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      StyledText("Binod Bhandari"),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        "Mobile App Developer",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.normal),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      kIsWeb
                          ? YouTubePlayerWidget(videoId: "X7yJfhYHUIw")
                          : YouTubePlayerScreen(),
                      Text(
                        "MSc Computer Science graduate with distinction and experience in developing mobile and web applications using Flutter, Spring Boot, and MySQL. Skilled in delivering innovative, user-focused solutions. Seeking to contribute technical expertise to a software development role in the UK.",
                        style: TextStyle(
                          fontFamily: "DancingScript",
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Social Links",
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Card(
                elevation: 2.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {
                          launchUrl(Uri.parse(
                              "https://www.linkedin.com/in/binod-bhandari-b40253183/"));
                        },
                        icon: Icon(FontAwesomeIcons.linkedin),
                        color: Colors.blueGrey,
                      ),
                      IconButton(
                        onPressed: () {
                          launchUrl(Uri.parse("https://cct.edu.np/"));
                        },
                        icon: Icon(FontAwesomeIcons.twitter),
                        color: Colors.blueAccent,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(FontAwesomeIcons.github),
                        color: Colors.blue,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(FontAwesomeIcons.googlePlay),
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Skills",
                style: (TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                )),
              ),
              SizedBox(
                height: 10.0,
              ),
              Card(
                elevation: 2.0,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                        "assets/images/beach.jpg",
                      ),
                    ),
                    title: Text(
                      "Mobile App Development",
                    ),
                    subtitle: Text("Dart, Flutter"),
                  ),
                ),
              ),
              Card(
                elevation: 2.0,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/images/beach.jpg",
                    ),
                  ),
                  title: Text(
                    "Web Development",
                  ),
                  subtitle: Text(
                    "html, css, js, php",
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "My Products",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Card(
                elevation: 2.0,
                child: DiceRoller(),
              ),
              Card(
                elevation: 2.0,
                child: MessageCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
