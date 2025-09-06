import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Apps',
        // style: TextStyle(
        //   fontWeight: FontWeight.bold,
        //   fontSize: 24.0,
        // ),
      ),
      centerTitle: true,
      // backgroundColor: Colors.teal,
      // leading: IconButton(
      //   icon: Icon(Icons.menu),
      //   onPressed: () {
      //     // Handle menu button press
      //   },
      // ),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            // Handle search button press
          },
        ),
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {
            // Handle notifications button press
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
