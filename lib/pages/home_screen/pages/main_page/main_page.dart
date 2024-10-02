import 'package:flutter/material.dart';
import 'package:tiktok_clone/pages/home_screen/pages/main_page/tabs/recomendations_tab.dart';
import 'package:tiktok_clone/pages/home_screen/pages/main_page/tabs/subscriptions_tab.dart';
import 'package:tiktok_clone/pages/search_page/pages/search_page.dart';

class MainPage extends StatefulWidget {

  final TabController? mainController;

  const MainPage({super.key, this.mainController});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: kToolbarHeight- 10),
        child: SafeArea(
          child: Stack(
            children: [
              TabBarView(
                physics: const PageScrollPhysics(),
                controller: widget.mainController,
                children: const [
                  SubscriptionsTab(),
                  RecomendationsTab(),
                ]
              ),
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: kToolbarHeight-20,
                  child: TabBar(
                    splashFactory: NoSplash.splashFactory,
                    indicatorColor: Colors.white,
                    labelPadding: const EdgeInsets.symmetric(horizontal:  7),
                    indicatorPadding: const EdgeInsets.symmetric(horizontal: 35),
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    tabAlignment: TabAlignment.center,
                    isScrollable: true,
                    unselectedLabelColor: Colors.white.withOpacity(0.4),
                    labelColor: Colors.white,
                    controller: widget.mainController, 
                    tabs: const [
                      Tab(text: "Подписки",),
                      Tab(text: "Рекомендации")
                    ]
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Icon(Icons.live_tv_rounded, color: Colors.white, size: 23),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchPage()));},
                    child: const Icon(
                      Icons.search, 
                      color: Colors.white, 
                      size: 27
                    )
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}