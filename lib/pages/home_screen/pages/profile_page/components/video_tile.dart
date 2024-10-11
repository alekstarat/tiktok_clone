import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/api/api_service_impl.dart';
import 'dart:math';

import 'package:video_player/video_player.dart';

class VideoTile extends StatefulWidget {

  final int id;
  final bool isHidden;

  const VideoTile({super.key, required this.id, required this.isHidden});

  @override
  State<VideoTile> createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoTile> {

  late final VideoPlayerController _controller;
  int? views;

  void getViews() async {
    await ApiServiceImpl().getVideo(widget.id).then((v) {
      if (mounted) {
        setState(() {
          views = v.views;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getViews();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'http://10.0.2.2:8000/video/raw/${widget.id}'))
      ..initialize().then((_) async {
        await _controller.setVolume(0);
        if (mounted) {
          setState(() {});
        }

      });
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width*0.33,
          child: VideoPlayer(
          _controller,
                  ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.transparent, Colors.transparent, Colors.black.withOpacity(0.5)],
              transform: const GradientRotation(pi/2)
            )
          ),
        ),
        Padding(
          padding: EdgeInsets.all(2.0),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.play_arrow_outlined, color: Colors.white, size: 15),
                Text(
                  views == null ? "" : views.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'PTSans',
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0
                  )
                )
              ],
            ),
          ),
        ),
        if (widget.isHidden) const Padding(
          padding: EdgeInsets.all(2.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Icon(
              CupertinoIcons.lock, 
              color: Colors.white, 
              size: 15
            ),
          ),
        )
      ],
    );
  }
}