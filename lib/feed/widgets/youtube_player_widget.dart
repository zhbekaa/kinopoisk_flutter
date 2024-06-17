import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerWidget extends StatelessWidget {
  final String url;

  const YoutubePlayerWidget({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    // Extract the videoId from the URL
    final String videoId = YoutubePlayer.convertUrlToId(url) ?? '';

    // If videoId is null, return an error widget
    
      return YoutubePlayer(
        controller: YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
          ),
        ),
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
      );
    
  }
}
