import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/components/loading_circle_animation.dart';
import 'package:tiktok_clone/pages/home_screen/pages/create_video_page/components/icon_tile.dart';
import 'package:tiktok_clone/pages/home_screen/pages/create_video_page/components/publish_video.dart';
import 'package:video_player/video_player.dart';

class VideoPreview extends StatefulWidget {
  final String video;

  const VideoPreview({super.key, required this.video});

  @override
  State<VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  late final VideoPlayerController _controller;

  final Map<String, IconData> icons = {
    "Настройки" : Icons.settings_rounded,
    "Изменить" : CupertinoIcons.rectangle_expand_vertical ,
    "Темы" : CupertinoIcons.rectangle_fill_on_rectangle_angled_fill,
    "Текст" : CupertinoIcons.textformat,
    "Стикеры" : Icons.face_retouching_natural,
    "Эффекты" : Icons.curtains_rounded,
    "Фильтры" : CupertinoIcons.color_filter ,
  };

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.video))
      ..initialize().then((v) {
        setState(() {
          _controller.setLooping(true);
          _controller.setVolume(1);
          _controller.play();
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller))
                : const LoadingCircleAnimation(),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 80),
              child: SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 110,
                    height: kToolbarHeight / 2,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4)
                    ),
                    child: const Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(CupertinoIcons.music_note_2, color: Colors.white, size: 15,),
                          SizedBox(width: 5,),
                          Text(
                            "Добавить муз...",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 16),
            child: Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                width: 55,
                child: ListView.separated(
                  
                  itemBuilder: (context, index) {
                    return IconTile(
                      text: icons.entries.toList()[index].key,
                      icon: icons.entries.toList()[index].value,
                    );
                  }, 
                  separatorBuilder: (context, index) => const SizedBox(height: 8,), 
                  itemCount: 7
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: kToolbarHeight / 1.5),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: kToolbarHeight / 1.5,
                    width: MediaQuery.of(context).size.width*0.495,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 25,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.blueAccent, width: 2),
                            shape: BoxShape.circle
                          ),
                          child: Container(
                            width: 24,
                            decoration: BoxDecoration(
                              color: Colors.grey[200300],
                              shape: BoxShape.circle
                            ),
                            child: const Center(
                              child: Icon(CupertinoIcons.person_fill, color: Colors.blueGrey, size: 14),
                            ),
                          )
                        ),
                        const SizedBox(width: 5,),
                        const Text(
                          "Ваша история",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    )
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const PublishVideo()));
                    },
                    child: Container(
                      height: kToolbarHeight / 1.5,
                      width: MediaQuery.of(context).size.width*0.495,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: const Center(
                        child: Text(
                          "Далее",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          )
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 16),
            child: SafeArea(
              child: Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                    shadows: [Shadow(color: Colors.black, blurRadius: 5)],
                    size: 30
                  )
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
