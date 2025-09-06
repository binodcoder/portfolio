import 'package:flutter/material.dart';

import '../../../../common_widgets/circle_avatar.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      accountName: Text("Binod Bhandari"),
      accountEmail: Text("binodcoder@gmail.com"),
      currentAccountPicture: CustomCircleAvatar(
        radius: 30.0,
        imagePath: "assets/images/photo.jpg",
      ),
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
    );
  }
}
