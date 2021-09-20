import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Shortcut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text("MS Word Shortcuts"),
        ),
        body: ListView.separated(
          separatorBuilder: (context, index) {
            return Divider(
              thickness: 3.0,
            );
          },
          itemCount: 5,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                radius: 22.0,
                backgroundColor: Colors.tealAccent,
                child: Text(
                  "1",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
              title: Text("CTRL + A"),
              subtitle: Text("Selects text"),
            );
          },
        ),
      ),
    );
  }
}
