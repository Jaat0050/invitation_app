 import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
// import 'package:flick_video_player/flick_video_player.dart';
// import 'package:flutter/services.dart';
// import 'package:video_player/video_player.dart';

class TutorialPlayer extends StatefulWidget {
  final String item;
  final String bgImage;
  final String caption;

  const TutorialPlayer(
      {super.key,
      required this.item,
      required this.bgImage,
      required this.caption});
  @override
  // ignore: library_private_types_in_public_api
  _TutorialPlayerState createState() => _TutorialPlayerState();
}

class _TutorialPlayerState extends State<TutorialPlayer> {
  // late FlickManager flickManager;
  late VideoPlayerController _controllers;

  @override
  void initState() {
    super.initState();
    // flickManager = FlickManager(
    //     autoPlay: false,
    //     videoPlayerController: VideoPlayerController.asset(
    //       widget.item,
    //     ));
    _controllers = VideoPlayerController.asset(
      widget.item,
    )..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    // flickManager.dispose();
    _controllers.dispose();
    super.dispose();
  }

  bool isPlayed = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(26),
          child: GestureDetector(
            onTap: () {
              setState(() {
                isPlayed = !isPlayed;
               
              });
              !isPlayed ? _controllers.pause() : _controllers.play();
            },
            child: SizedBox(
         
              child: VideoPlayer(
                _controllers,
              ),
            ),
          ),
        ),
        isPlayed
            ? Container()
            : Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(widget.bgImage), fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.black.withOpacity(0.4)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 220,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isPlayed = !isPlayed;
                          
                          });
                          !isPlayed
                              ? _controllers.pause()
                              : _controllers.play();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(9),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 56, vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                // radius: 20,
                                minRadius: 10,
                                backgroundColor: const Color(0xff007663),
                                child: Icon(
                                  isPlayed ? Icons.pause : Icons.play_arrow,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 9,
                              ),
                              const Text(
                                'Watch Video',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Montserrat',
                                  color: Color(0xff007663),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        widget.caption,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Roboto',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}
