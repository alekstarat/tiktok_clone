import 'package:flutter/material.dart';
import 'package:tiktok_clone/components/video_screen.dart';

class RecomendationsTab extends StatefulWidget {
  const RecomendationsTab({super.key});

  @override
  State<RecomendationsTab> createState() => _RecomendationsTabState();
}

class _RecomendationsTabState extends State<RecomendationsTab> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {

  late final TabController _controller;
  List<int> ids = [1, 2];
  List<VideoScreen> loadedVideos = [];
  
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: ids.length, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - kToolbarHeight + 10,
      child: RotatedBox(
        quarterTurns: 1,
        child: TabBarView(
          controller: _controller,
          children: List.generate(ids.length, (int i) {
            return RotatedBox(
              quarterTurns: 3,
              child: VideoScreen(index: ids[i])
            );
          })
        ),
      )
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}