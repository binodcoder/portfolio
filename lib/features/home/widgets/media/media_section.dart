import 'package:binodfolio/features/home/widgets/media/youtube_player.dart';
import 'package:binodfolio/features/home/widgets/media/youtube_player_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MediaSection extends StatelessWidget {
  const MediaSection();
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Gratuation',
            style: t.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 12),
        kIsWeb
            ? YouTubePlayerWidget(videoId: "X7yJfhYHUIw")
            : YouTubePlayerScreen(),
      ],
    );
  }
}
