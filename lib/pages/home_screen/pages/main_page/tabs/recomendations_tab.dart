import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiktok_clone/components/video_screen.dart';
import 'package:tiktok_clone/packages/user_repository/user_repository_impl.dart';
import 'package:tiktok_clone/pages/home_screen/home_bloc/home_bloc.dart';

class RecomendationsTab extends StatefulWidget {
  const RecomendationsTab({super.key});

  @override
  State<RecomendationsTab> createState() => _RecomendationsTabState();
}

class _RecomendationsTabState extends State<RecomendationsTab>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  List<int> ids = [1, 2, 3, 2, 4, 2, 1, 3, 1, 4, 1, 4, 3, 3, 1, 2]..shuffle();
  List<Widget> loadedVideos = [];
  int viewsCount = 0, currIdx = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  void _loadVideos() {
    setState(() {
      loadedVideos.addAll(List<Widget>.generate(
          5,
          (index) => RepositoryProvider(
                create: (_) => context.read<UserRepository>(),
                child: BlocProvider(
                  create: (_) => context.read<HomeBloc>(),
                  child:
                      VideoScreen(index: ids[index], fromRecomendations: true),
                ),
              )));
    });
    print("LOADED VIDEOS: ${loadedVideos.length}");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - kToolbarHeight + 10,
        child: CarouselSlider(
            carouselController: _controller,
            items: loadedVideos,
            options: CarouselOptions(
              scrollDirection: Axis.vertical,
              viewportFraction: 1,
              enableInfiniteScroll: false,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                if (index >= currIdx) {
                  setState(() {
                    currIdx = index;
                  });
                }
                print("currIdx: $currIdx");
                if (index % loadedVideos.length - 1 == 0) {
                  _loadVideos();
                }
              },
            )));
  }

  @override
  bool get wantKeepAlive => true;
}
