import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested_scroll_views/material.dart';
import 'package:tiktok_clone/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:tiktok_clone/packages/user_repository/user_repository_impl.dart';
import 'package:tiktok_clone/pages/home_screen/home_bloc/home_bloc.dart';
import 'package:tiktok_clone/pages/home_screen/pages/create_video_page/create_video_page.dart';
import 'package:tiktok_clone/pages/home_screen/pages/friends_page/friends_page.dart';
import 'package:tiktok_clone/pages/home_screen/pages/main_page/main_page.dart';
import 'package:tiktok_clone/pages/home_screen/pages/messages_page/messages_page.dart';
import 'package:tiktok_clone/pages/home_screen/pages/profile_page/profile_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController, _mainController;

  int currPage = 1;
  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 2,
        vsync: this,
        animationDuration: const Duration(milliseconds: 200));
    _mainController = TabController(
        length: 2,
        vsync: this,
        initialIndex: 1,
        animationDuration: const Duration(milliseconds: 200));
    pages = [
      RepositoryProvider(
        create: (_) => context.read<UserRepository>(),
        child: MainPage(
          mainController: _mainController,
          onProfileTap: () {
            _tabController.animateTo(1);
          },
        ),
      ),
      const FriendsPage(),
      const MessagesPage(),
      RepositoryProvider(
        create: (_) => context.read<UserRepository>(),
        child: ProfilePage(
          id: context.read<UserRepository>().userId ?? 0,
          fromVideo: false,
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: NestedTabBarView(
            physics: currPage == 1
                ? const PageScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            dragStartBehavior: DragStartBehavior.down,
            controller: _tabController,
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: RepositoryProvider(
                      create: (_) => context.read<UserRepository>(),
                      child: MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (_) => HomeBloc(
                                userRepo: context.read<UserRepository>()),
                          ),
                          BlocProvider(
                            create: (_) => context.read<AuthBloc>(),
                          ),
                        ],
                        child: pages[currPage - 1],
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                            color: currPage == 1 || currPage == 2
                                ? Colors.black
                                : Colors.white,
                            border: Border(
                                top: BorderSide(
                                    color: currPage == 3 || currPage == 4
                                        ? Colors.grey.shade300
                                        : Colors.grey.shade800,
                                    width: currPage == 3 || currPage == 4
                                        ? 1
                                        : 2))),
                        height: kToolbarHeight - 10,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currPage = 1;
                                    });
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                          currPage == 1
                                              ? CupertinoIcons.house_fill
                                              : CupertinoIcons.house,
                                          color: currPage == 1
                                              ? Colors.white
                                              : Colors.grey,
                                          size: 25,
                                          weight: 1,
                                          grade: -25),
                                      Text(
                                        "Главная",
                                        style: TextStyle(
                                            color: currPage == 1
                                                ? Colors.white
                                                : Colors.grey,
                                            fontSize: 9),
                                      )
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currPage = 2;
                                    });
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        currPage == 2
                                            ? CupertinoIcons.person_2_fill
                                            : CupertinoIcons.person_2,
                                        color: currPage == 2
                                            ? Colors.white
                                            : Colors.grey,
                                        grade: -25,
                                        size: 25,
                                        weight: 1,
                                      ),
                                      Text(
                                        "Друзья",
                                        style: TextStyle(
                                            color: currPage == 2
                                                ? Colors.white
                                                : Colors.grey,
                                            fontSize: 9),
                                      )
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () async {

                                      await availableCameras().then((v) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CreateVideoPage(cameras: v)));
                                        return v;
                                      });

                                      
                                    },
                                    child: SizedBox(
                                      width: 40,
                                      height: kToolbarHeight - 25,
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              width: 30,
                                              height: kToolbarHeight - 30,
                                              decoration: BoxDecoration(
                                                  color: Colors.lightBlueAccent,
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              width: 30,
                                              height: kToolbarHeight - 30,
                                              decoration: BoxDecoration(
                                                  color: Colors.redAccent,
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              width: 35,
                                              height: kToolbarHeight - 30,
                                              decoration: BoxDecoration(
                                                  color: currPage == 3 ||
                                                          currPage == 4
                                                      ? Colors.black
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(9)),
                                              child: Icon(
                                                Icons.add,
                                                color: currPage == 3 ||
                                                        currPage == 4
                                                    ? Colors.white
                                                    : Colors.black,
                                                size: 20,
                                                grade: -25,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currPage = 3;
                                    });
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        currPage == 3
                                            ? Icons.message_rounded
                                            : Icons.message_outlined,
                                        color: currPage == 3
                                            ? Colors.black
                                            : Colors.grey,
                                        size: 25,
                                        grade: -25,
                                        weight: 1,
                                      ),
                                      Text(
                                        "Входящие",
                                        style: TextStyle(
                                          color: currPage == 3
                                              ? Colors.black
                                              : Colors.grey,
                                          fontSize: 9,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currPage = 4;
                                    });
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        currPage == 4
                                            ? CupertinoIcons.person_fill
                                            : CupertinoIcons.person,
                                        color: currPage == 4
                                            ? Colors.black
                                            : Colors.grey,
                                        grade: -25,
                                        size: 25,
                                        weight: 1,
                                      ),
                                      Text(
                                        "Профиль",
                                        style: TextStyle(
                                            color: currPage == 4
                                                ? Colors.black
                                                : Colors.grey,
                                            fontSize: 9),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                ],
              ),
              ProfilePage(
                id: 1,
                fromVideo: true,
                onBack: () {
                  _tabController.animateTo(0);
                },
              )
            ],
          ),
        );
  }
}
