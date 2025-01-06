import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Binod Bhandari"),
            accountEmail: Text("binodcoder@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/profile_picture.png"),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Profile"),
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            leading: Icon(Icons.work),
            title: Text("Experience"),
            onTap: () {
              Navigator.pushNamed(context, '/experience');
            },
          ),
          ListTile(
            leading: Icon(Icons.school),
            title: Text("Education"),
            onTap: () {
              Navigator.pushNamed(context, '/education');
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text("Contact"),
            onTap: () {
              Navigator.pushNamed(context, '/contact');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Logout"),
            onTap: () {
              // Add logout functionality here
            },
          ),
        ],
      ),
    );
  }
}
