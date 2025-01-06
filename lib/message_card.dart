import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  static var themeColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "my app",
      theme: ThemeData(
        primarySwatch: themeColor,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State {
  TextEditingController controller = TextEditingController();
  String message = "Welcome to message card!";
  Color themeColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        title: Text(
          "Message Card App",
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              height: 200.0,
              color: themeColor,
              child: Center(
                child: Text(
                  message,
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              onChanged: (String newValue) {
                setState(() {
                  message = newValue;
                });
              },
              maxLength: 30,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2.0,
                    color: themeColor,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.edit,
                  color: themeColor,
                ),
                hintText: "Your message",
                helperText: "You can type your message here",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                controller.clear();
              },
              child: Text(
                "Clear",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          themeColor = Colors.red;
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          themeColor = Colors.green;
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.green,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          themeColor = Colors.blue;
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.blue,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          themeColor = Colors.yellow;
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.yellow,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
