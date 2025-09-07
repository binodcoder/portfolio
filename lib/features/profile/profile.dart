import 'package:flutter/material.dart';
import 'package:binodfolio/common_widgets/in_app_back_button.dart';
import 'widgets/gradient_container.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  if (Navigator.of(context).canPop()) ...[
                    const InAppBackButton(),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    'Apps',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: GradientContainer(
                [
                  const Color.fromARGB(255, 214, 208, 226),
                  const Color.fromARGB(255, 158, 145, 177),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
