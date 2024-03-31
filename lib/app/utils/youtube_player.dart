import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubePlayerDemo extends StatefulWidget {
  final String vedioUrl;
  final double aspectRatio;

  const YouTubePlayerDemo({
    super.key,
    required this.vedioUrl,
    required this.aspectRatio,
  });
  @override
  // ignore: library_private_types_in_public_api
  _YouTubePlayerDemoState createState() => _YouTubePlayerDemoState();
}

class _YouTubePlayerDemoState extends State<YouTubePlayerDemo> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    // Extract the video ID from the YouTube link
    String extractVideoId(String youtubeUrl) {
      RegExp regExp = RegExp(
        r'^https?:\/\/(?:www\.)?youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=|youtu\.be\/)([a-zA-Z0-9_-]{11})',
      );
      RegExpMatch? match =
          regExp.firstMatch(youtubeUrl) ?? RegExp('').firstMatch('');
      return match!.group(1) ?? '';
    }

    String videoId = extractVideoId(widget.vedioUrl);

    _controller = YoutubePlayerController.fromVideoId(
        videoId: videoId,
        autoPlay: true,
        params: const YoutubePlayerParams(
          mute: false,
          showFullscreenButton: false,
          enableCaption: false,
          enableJavaScript: true,
          enableKeyboard: false,
          playsInline: true,
          strictRelatedVideos: true,
          showVideoAnnotations: false,
          showControls: false,
        )

        // initialVideoId: videoId,
        // flags: const YoutubePlayerFlags(
        //   autoPlay: false,
        //   mute: false,
        //   disableDragSeek: true,
        //   showLiveFullscreenButton: false,
        // ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      // width: 320,
      aspectRatio: widget.aspectRatio,
      controller: _controller,
      enableFullScreenOnVerticalDrag: false,

      // showVideoProgressIndicator: false,
      // progressIndicatorColor: Colors.blueAccent,
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
