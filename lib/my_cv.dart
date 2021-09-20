import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled/word_shortcut.dart';
import 'package:url_launcher/url_launcher.dart';

import 'message_card.dart';

class MyCv extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Resume",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 2.0,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 30.2, horizontal: 20.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 60.0,
                        backgroundImage: AssetImage("assets/images/beach.jpg"),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        "Binod Bhandari",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                      Text(
                        "I am learning dart and flutter eventually and looking for internship. I want to learn  and grow from the organization.",
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
                          launch(
                              "https://www.linkedin.com/in/binod-bhandari-b40253183/");
                        },
                        icon: Icon(FontAwesomeIcons.linkedin),
                        color: Colors.blueGrey,
                      ),
                      IconButton(
                        onPressed: () {
                          launch("https://cct.edu.np/");
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
              Card(
                elevation: 2.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Hello Flutter",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
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
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MessageCard()),
                        );
                      },
                      child: Text(
                        "Message Card",
                        overflow: TextOverflow.ellipsis,
                        textWidthBasis: TextWidthBasis.parent,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Shortcut()),
                        );
                      },
                      child: Text(
                        "Shortcuts",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
