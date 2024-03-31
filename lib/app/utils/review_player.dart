//  // import 'package:flutter/material.dart';
// // import 'package:flick_video_player/flick_video_player.dart';
// // import 'package:flutter/services.dart';
// import 'package:video_player/video_player.dart';

 import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ReviewPlayer extends StatefulWidget {
  final Map<String, dynamic> item;
  final VideoPlayerController controller;

  const ReviewPlayer({Key? key, required this.item, required this.controller})
      : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _ReviewPlayerState createState() => _ReviewPlayerState();
}

class _ReviewPlayerState extends State<ReviewPlayer> {
  // late VideoPlayerController _controller;
  // late FlickManager flickManager;

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = VideoPlayerController.networkUrl(
  //     Uri.parse(
  //       widget.item["videoUrl"],
  //     ),
  //   )..initialize().then((_) {
  //       // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
  //       setState(() {});
  //     });
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _controller.dispose();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   // flickManager = FlickManager(
  //   //     autoPlay: false,
  //   //     videoPlayerController: VideoPlayerController.networkUrl(
  //   //       Uri.parse(widget.item["videoUrl"]),
  //   //     ));
  // }

  // @override
  // void dispose() {
  //   flickManager.dispose();
  //   super.dispose();
  // }

  bool isPlayed = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200,
      // width: 300,
      padding: const EdgeInsets.all(40),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              // child: FlickVideoPlayer(
              //   flickVideoWithControls: FlickVideoWithControls(
              //     willVideoPlayerControllerChange: false,
              //     controls: FlickPortraitControls(
              //       fontSize: 0,
              //       iconSize: 0,
              //       progressBarSettings: FlickProgressBarSettings(
              //         height: 0,
              //         playedColor: Colors.transparent,
              //         bufferedColor: Colors.transparent,
              //         handleColor: Colors.transparent,
              //         backgroundColor: Colors.transparent,
              //       ),
              //     ),
              //   ),
              //   preferredDeviceOrientation: const [
              //     DeviceOrientation.portraitUp,
              //     DeviceOrientation.portraitDown
              //   ],
              //   flickManager: FlickManager(
              //     autoPlay: false,
              //     videoPlayerController: VideoPlayerController.networkUrl(
              //       Uri.parse(
              //         widget.item["videoUrl"],
              //       ),
              //     ),
              //   ),
              // ),
              child: widget.controller.value.isInitialized
                  ? VideoPlayer(
                      widget.controller,
                    )
                  : Container(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item["name"],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      "Trusted us With Video Invite",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isPlayed = !isPlayed;
                     
                      widget.controller.value.isPlaying
                          ? widget.controller.pause()
                          : widget.controller.play();
                    });
                    // flickManager.flickControlManager?.togglePlay();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.black38),
                    child: Icon(
                      widget.controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      size: 36,
                      color: Colors.white,
                    ),
                  ),
                ),

                // SizedBox(width: 20),
                // ElevatedButton(
                //   onPressed: () {
                //     flickManager.flickControlManager?.togglePlay();
                //   },
                //   child: Icon(Icons.volume_up, size: 40),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
