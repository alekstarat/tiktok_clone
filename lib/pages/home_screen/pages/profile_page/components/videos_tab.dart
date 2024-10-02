import 'package:flutter/material.dart';
import 'package:tiktok_clone/components/video_screen.dart';
import 'package:tiktok_clone/pages/home_screen/pages/profile_page/components/video_tile.dart';

class VideosTab extends StatelessWidget {

  final bool isHidden;

  const VideosTab({super.key, required this.isHidden});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 0.75, crossAxisCount: 3, mainAxisSpacing: 1, crossAxisSpacing: 1),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const VideoScreen(index: 1, fromRecomendations: false,)));
          },
          child: VideoTile(id: index, isHidden: isHidden,)
        );
      }
    );
  }
}