import 'package:flutter/material.dart';

import 'drawer_header.dart';
import 'drawer_item.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          CustomDrawerHeader(),
          DrawerItem(
            icon: Icons.work,
            text: 'Experience',
            onTap: () => Navigator.pushNamed(context, '/experience'),
          ),
          DrawerItem(
            icon: Icons.school,
            text: 'Education',
            onTap: () => Navigator.pushNamed(context, '/education'),
          ),
          DrawerItem(
            icon: Icons.contact_mail,
            text: 'Contact',
            onTap: () => Navigator.pushNamed(context, '/contact'),
          ),
          Divider(),
          DrawerItem(
            icon: Icons.settings,
            text: 'Settings',
            onTap: () => Navigator.pushNamed(context, '/settings'),
          ),
          DrawerItem(
            icon: Icons.exit_to_app,
            text: 'Logout',
            onTap: () {
              // Add logout functionality here
            },
          ),
        ],
      ),
    );
  }
}
