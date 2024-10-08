import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_clone/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:tiktok_clone/components/video_screen.dart';
import 'package:tiktok_clone/pages/home_screen/home_bloc/home_bloc.dart';
import 'package:tiktok_clone/pages/home_screen/pages/profile_page/components/video_tile.dart';

class VideosTab extends StatefulWidget {
  final bool isHidden;
  final List<int> videos;

  const VideosTab({super.key, required this.isHidden, required this.videos});

  @override
  State<VideosTab> createState() => _VideosTabState();
}

class _VideosTabState extends State<VideosTab> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GridView.builder(
        itemCount: widget.videos.length,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.75,
            crossAxisCount: 3,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1),
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                print("select video");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                  create: (_) => context.read<HomeBloc>(),
                                ),
                                BlocProvider(
                                  create: (_) => context.read<AuthBloc>(),
                                ),
                              ],
                              child: BlocBuilder<HomeBloc, HomeState>(
                                builder: (context, state) {
                                  return VideoScreen(
                                    index: widget.videos[index],
                                    fromRecomendations: false,
                                  );
                                },
                              ),
                            )));
              },
              child: VideoTile(
                id: widget.videos[index],
                isHidden: widget.isHidden,
              ));
        });
  }
  
  @override
  bool get wantKeepAlive => true;
}
