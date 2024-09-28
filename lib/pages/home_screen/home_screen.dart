import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

class _HomeScreenState extends State<HomeScreen> {

  int currPage = 1;
  List<Widget> pages = [const MainPage(), const FriendsPage(), const MessagesPage(), const ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: pages[currPage-1],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: currPage == 1 || currPage == 2  ? Colors.black : Colors.white,
                border: Border(top: BorderSide(color: currPage == 3 || currPage == 4 ? Colors.grey.shade300 : Colors.grey.shade800, width: currPage == 3 || currPage == 4 ? 1 : 2))
              ),
              height: kToolbarHeight- 10,
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
                            Icon(currPage == 1 ? CupertinoIcons.house_fill : CupertinoIcons.house, color: currPage == 1 ? Colors.white : Colors.grey, size: 25, weight: 1, grade: -25),
                            Text(
                              "Главная",
                              style: TextStyle(
                                color: currPage == 1 ? Colors.white : Colors.grey,
                                fontSize: 9
                              ),
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
                            Icon(currPage == 2 ? CupertinoIcons.person_2_fill : CupertinoIcons.person_2, color: currPage == 2 ? Colors.white : Colors.grey, grade: -25, size: 25, weight: 1,),
                            Text(
                              "Друзья",
                              style: TextStyle(
                                color: currPage == 2 ? Colors.white : Colors.grey,
                                fontSize: 9
                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateVideoPage()));
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
                                    borderRadius: BorderRadius.circular(6)
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  width: 30,
                                  height: kToolbarHeight - 30,
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(6)
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 35,
                                  height: kToolbarHeight - 30,
                                  decoration: BoxDecoration(
                                    color: currPage == 3 || currPage == 4 ? Colors.black : Colors.white,
                                    borderRadius: BorderRadius.circular(9)
                                  ),
                                  child: Icon(Icons.add, color: currPage == 3 || currPage == 4 ? Colors.white : Colors.black, size: 20, grade: -25,),
                                ),
                              )
                            ],
                          ),
                        )
                      ),
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
                            Icon(currPage == 3 ? Icons.message_rounded : Icons.message_outlined, color: currPage == 3 ? Colors.black : Colors.grey, size: 25, grade: -25, weight: 1,),
                            Text(
                              "Входящие",
                              style: TextStyle(
                                color: currPage == 3 ? Colors.black : Colors.grey,
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
                            Icon(currPage == 4 ? CupertinoIcons.person_fill : CupertinoIcons.person, color: currPage == 4 ? Colors.black : Colors.grey, grade: -25, size: 25, weight: 1,),
                            Text(
                              "Профиль",
                              style: TextStyle(
                                color: currPage == 4 ? Colors.black : Colors.grey,
                                fontSize: 9
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ),
        ],
      ),
    );
  }
}