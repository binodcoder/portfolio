import 'package:binodfolio/features/home/widgets/media/youtube_player.dart';
import 'package:binodfolio/features/home/widgets/media/youtube_player_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:binodfolio/core/responsive/sizes.dart';

class MediaSection extends StatelessWidget {
  const MediaSection();
  @override
  Widget build(BuildContext context) {
    // Title removed as requested; render the media only
    final child = kIsWeb
        ? YouTubePlayerWidget(videoId: "X7yJfhYHUIw")
        : YouTubePlayerScreen();

    final radius = BorderRadius.circular(context.radius(12));

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: radius),
      child: ClipRRect(
        borderRadius: radius,
        child: child,
      ),
    );
  }
}
