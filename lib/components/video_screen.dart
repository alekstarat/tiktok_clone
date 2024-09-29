import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tiktok_clone/components/comments_widget.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {

  final int index;

  const VideoScreen({super.key, required this.index});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late final VideoPlayerController _controller;
  bool isPaused = false;
  double turns = 10;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/${widget.index}.mp4')
      ..initialize().then((_) async {
        setState(() {});
        _controller.setLooping(true);
        await _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      trackpadScrollCausesScale: false,
      onTap: () async {
        if (_controller.value.isPlaying) {
          await _controller.pause();
          setState(() {
            isPaused = true;
          });
        } else {
          await _controller.play();
          setState(() {
            isPaused = false;
          });
        }
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - kToolbarHeight + 10,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: _controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    )
                  : const CircularProgressIndicator(),
            ),
            IgnorePointer(
              ignoring: true,
              child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 150),
                  opacity: isPaused ? 1 : 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration:
                        BoxDecoration(color: Colors.black.withOpacity(0.3)),
                    child: Center(
                      child: Icon(Icons.play_arrow_rounded,
                          color: Colors.grey.shade400.withOpacity(0.5),
                          size: 50),
                    ),
                  )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 2,
                  child: VideoProgressIndicator(
                    _controller,
                    allowScrubbing: true,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    colors: VideoProgressColors(
                      playedColor: Colors.white,
                      backgroundColor: Colors.grey.shade800,
                    ),
                  )),
            ),

          // Лайки комменты ------------------------------------------------------

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 35,
                      height: 45,
                      child: Stack(
                        fit: StackFit.passthrough,
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    blurRadius: 5
                                  )
                                ],
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                                color: const Color.fromARGB(255, 192, 168, 159)),
                            child: const Center(
                                child: Icon(Icons.person,
                                    color: Colors.white, 
                                    size: 30
                                  )
                                ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Center(
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    blurRadius: 5
                                  )
                                ],
                                ),
                                child: const Center(
                                  child: Icon(Icons.add, color: Colors.white, size: 15),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.favorite_rounded, color: Colors.white, size: 35, shadows: [Shadow(color: Colors.black.withOpacity(0.5), blurRadius: 10)],),
                        Text(
                          "1488",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            shadows: [Shadow(color: Colors.black.withOpacity(1), blurRadius: 10)]
                          )
                        )
                      ],
                    ),
                    const SizedBox(height: 10,),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          shape:  const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(14))),
                          barrierColor: Colors.transparent,
                          context: context, 
                          builder: (context) => GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                            },
                            child: const CommentsWidget()
                          )
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //Icon(Icons.insert_comment_rounded, color: Colors.white, size: 35),
                          Icon(CupertinoIcons.chat_bubble_text_fill, color: Colors.white, size: 30, shadows: [Shadow(color: Colors.black.withOpacity(0.5), blurRadius: 10)]),
                          Text(
                            "52",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              shadows: [Shadow(color: Colors.black.withOpacity(1), blurRadius: 10)]
                            )
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //Icon(Icons.bookmark_rounded, color: Colors.white, size: 35),
                        Icon(CupertinoIcons.bookmark_fill, color: Colors.white, size: 30, shadows: [Shadow(color: Colors.black.withOpacity(0.5), blurRadius: 10)]),
                        Text(
                          "295",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            shadows: [Shadow(color: Colors.black.withOpacity(1), blurRadius: 15)]
                          )
                        )
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Transform.rotate(angle: -pi/2 ,child: Icon(CupertinoIcons.arrow_turn_right_down, color: Colors.white, size: 30, shadows: [Shadow(color: Colors.black.withOpacity(0.5), blurRadius: 10)])),
                        Text(
                          "109",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            shadows: [Shadow(color: Colors.black.withOpacity(1), blurRadius: 10)]
                          )
                        )
                      ],
                    ),
                    const SizedBox(height: 15,),
                    AnimatedRotation(
                      turns: 0.0, duration: const Duration(minutes: 10),
                      filterQuality: FilterQuality.high,
                      child: SizedBox(
                        child: SvgPicture.asset(
                          'assets/images/vinyl.svg',
                          width: 35,
                        )
                      )
                    )
                  ],
                ),
                // Название и описание ------------------------------------------------------------------------------
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("djmis.t", style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                    ),),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Text("черепа на хате ", style: TextStyle(
                          color: Colors.white,
                        ),),
                        Text("#черепа #на #хате", style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
