import 'package:binodfolio/features/home/widgets/media/youtube_player.dart';
import 'package:binodfolio/features/home/widgets/media/youtube_player_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MediaSection extends StatelessWidget {
  const MediaSection();
  @override
  Widget build(BuildContext context) {
    // Title removed as requested; render the media only
    return kIsWeb
        ? YouTubePlayerWidget(videoId: "X7yJfhYHUIw")
        : YouTubePlayerScreen();
  }
}
