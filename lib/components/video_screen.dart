import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tiktok_clone/components/comments_widget.dart';
import 'package:tiktok_clone/components/loading_screen.dart';
import 'package:tiktok_clone/pages/search_page/pages/search_page.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  final int index;
  final bool fromRecomendations;

  const VideoScreen(
      {super.key, required this.index, required this.fromRecomendations});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late final VideoPlayerController _controller;
  bool isPaused = false;
  double turns = 10;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.asset('assets/videos/${widget.index}.mp4')
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
    return Material(
      type: MaterialType.transparency,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        trackpadScrollCausesScale: false,
        onTap: () async {
          _focusNode.unfocus();
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
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height -
                            kToolbarHeight +
                            10,
                        width: _controller.value.size.width,
                        child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                      )
                    : const LoadingScreen(),
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
              IgnorePointer(
                child: Container(
                  width: double.infinity,
                  height: 250,
                  decoration:
                      BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.black.withOpacity(0.5), Colors.transparent, Colors.transparent],
                          transform: const GradientRotation(pi/2)
                        )
                      ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: IgnorePointer(
                  child: Container(
                    width: double.infinity,
                    height: 250,
                    decoration:
                        BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.black.withOpacity(0.5), Colors.transparent, Colors.transparent],
                            transform: const GradientRotation(3*pi/2)
                          )
                        ),
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(bottom: widget.fromRecomendations ? 0 : 30),
                child: Align(
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
              ),

              // Лайки комменты ------------------------------------------------------

              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: widget.fromRecomendations ? 8 : 38),
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
                                        blurRadius: 5)
                                  ],
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.white, width: 1),
                                  color:
                                      const Color.fromARGB(255, 192, 168, 159)),
                              child: const Center(
                                  child: Icon(Icons.person,
                                      color: Colors.white, size: 30)),
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
                                          blurRadius: 5)
                                    ],
                                  ),
                                  child: const Center(
                                    child: Icon(Icons.add,
                                        color: Colors.white, size: 15),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.favorite_rounded,
                            color: Colors.white,
                            size: 35,
                            shadows: [
                              Shadow(
                                  color: Colors.black.withOpacity(0.5),
                                  blurRadius: 10)
                            ],
                          ),
                          Text("1488",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  shadows: [
                                    Shadow(
                                        color: Colors.black.withOpacity(1),
                                        blurRadius: 10)
                                  ]))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(14))),
                              barrierColor: Colors.transparent,
                              context: context,
                              builder: (context) => GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                  },
                                  child: const CommentsWidget()));
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //Icon(Icons.insert_comment_rounded, color: Colors.white, size: 35),
                            Icon(CupertinoIcons.chat_bubble_text_fill,
                                color: Colors.white,
                                size: 30,
                                shadows: [
                                  Shadow(
                                      color: Colors.black.withOpacity(0.5),
                                      blurRadius: 10)
                                ]),
                            Text("52",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black.withOpacity(1),
                                          blurRadius: 10)
                                    ]))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //Icon(Icons.bookmark_rounded, color: Colors.white, size: 35),
                          Icon(CupertinoIcons.bookmark_fill,
                              color: Colors.white,
                              size: 30,
                              shadows: [
                                Shadow(
                                    color: Colors.black.withOpacity(0.5),
                                    blurRadius: 10)
                              ]),
                          Text("295",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  shadows: [
                                    Shadow(
                                        color: Colors.black.withOpacity(1),
                                        blurRadius: 15)
                                  ]))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Transform.rotate(
                              angle: -pi / 2,
                              child: Icon(CupertinoIcons.arrow_turn_right_down,
                                  color: Colors.white,
                                  size: 30,
                                  shadows: [
                                    Shadow(
                                        color: Colors.black.withOpacity(0.5),
                                        blurRadius: 10)
                                  ])),
                          Text("109",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  shadows: [
                                    Shadow(
                                        color: Colors.black.withOpacity(1),
                                        blurRadius: 10)
                                  ]))
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      AnimatedRotation(
                          turns: 0.0,
                          duration: const Duration(minutes: 10),
                          filterQuality: FilterQuality.high,
                          child: SizedBox(
                              child: SvgPicture.asset(
                            'assets/images/vinyl.svg',
                            width: 35,
                          )))
                    ],
                  ),
                  // Название и описание ------------------------------------------------------------------------------
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: widget.fromRecomendations ? 16 : 46,
                    horizontal: 8),
                child: const Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "djmis.t",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            "черепа на хате ",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "#черепа #на #хате",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Нижняя строка поиска ------------------------------------------------------------------------------------------
              if (!widget.fromRecomendations)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        _focusNode.requestFocus();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text("Добавить комментарий...",
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontFamily: 'PTSans',
                                  fontSize: 14)),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.alternate_email_rounded,
                                color: Colors.grey[500],
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Icon(
                                Icons.emoji_emotions_outlined,
                                color: Colors.grey[500],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              if (!widget.fromRecomendations)
                Positioned(
                  bottom: !_focusNode.hasPrimaryFocus ||
                          MediaQuery.of(context).viewInsets.bottom == 0
                      ? -2 * (kToolbarHeight / 1.5)
                      : MediaQuery.of(context).viewInsets.bottom,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Divider(
                              color: Colors.grey.shade400,
                              height: 0,
                              thickness: 0),
                          SizedBox(
                            height: kToolbarHeight / 1.5,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                      width: 16,
                                    ),
                                scrollDirection: Axis.horizontal,
                                itemCount: 20,
                                shrinkWrap: true,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                itemBuilder: (context, index) {
                                  return const Icon(Icons.emoji_emotions,
                                      color: Colors.black, size: 30);
                                }),
                          ),
                          Container(
                            color: Colors.white,
                            height: kToolbarHeight / 1.5,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const CircleAvatar(
                                  backgroundColor: Color(0xFFB57B7B),
                                  radius: 15,
                                  child: Icon(CupertinoIcons.person_fill,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width - 52,
                                  height: 30,
                                  child: CupertinoTextField(
                                    focusNode: _focusNode,
                                    cursorColor: Colors.red,
                                    cursorWidth: 1,
                                    placeholder: "Добавить комментарий...",
                                    placeholderStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey.withOpacity(0.5)),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(90),
                                    ),
                                    suffix: const Padding(
                                      padding: EdgeInsets.only(right: 8),
                                      child: SizedBox(
                                        width: 80,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(
                                              Icons.alternate_email_rounded,
                                              color: Colors.black,
                                            ),
                                            Icon(Icons.emoji_emotions_outlined),
                                            Icon(
                                              CupertinoIcons.gift,
                                              color: Colors.black,
                                              size: 21,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          //SizedBox(height: MediaQuery.of(context).viewInsets.bottom,)
                        ],
                      ),
                    ),
                  ),
                ), // Верхнаяя строка поиска -------------------------------------------------------------------------------------------------------
              if (!widget.fromRecomendations)
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.arrow_back_rounded,
                                color: Colors.white, size: 28)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchPage()));
                          },
                          child: Container(
                            height: 28,
                            width: MediaQuery.of(context).size.width * 0.88,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                    color: Colors.white.withOpacity(0.7),
                                    width: 0.35)),
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(CupertinoIcons.search,
                                            color: Colors.white, size: 12),
                                        SizedBox(width: 3),
                                        Text("Найти связанный контент",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'PTSans',
                                              fontSize: 12,
                                            )),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 1,
                                          height: 15,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(90)),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text("Поиск",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'PTSans',
                                              fontSize: 12,
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
