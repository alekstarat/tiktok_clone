import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nested_scroll_views/material.dart';
import 'package:tiktok_clone/pages/home_screen/pages/profile_page/components/bookmark_tab.dart';
import 'package:tiktok_clone/pages/home_screen/pages/profile_page/components/videos_tab.dart';

class ProfilePage extends StatefulWidget {

  final int id;
  final bool fromVideo;
  final Function? onBack;

  const ProfilePage({super.key, required this.id, required this.fromVideo, this.onBack});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin{

  late final TabController _tabController;
  late final Widget tab1;
  bool filterPopular = false;

  double currentExtent = 0.0;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    tab1 = SizedBox(
        width: 35,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: RotatedBox(
                quarterTurns: 1,
                child: Icon(CupertinoIcons.rectangle_grid_3x2_fill, 
                  size: 20,
                  color: _tabController.index == 0 
                    ? Colors.black 
                    : Colors.black.withOpacity(0.7)
                  ),
              ),
            ),
            const Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.arrow_drop_down_rounded, size: 25, color: Colors.black,)
            )
          ],
        ),
      );
  }

  Widget settingsMenu() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12))
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            horizontalTitleGap: 8,
            leading: Icon(CupertinoIcons.person_crop_circle_badge_plus, color: Colors.black, size: 30),
            title: Text(
              "Инструменты автора",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'PTSans',
                fontWeight: FontWeight.bold,
                fontSize: 14
              )
            ),
          ),
          Divider(color: Colors.grey[600], indent: 8, endIndent: 8, thickness: 0.25, height: 0,),
          const ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            horizontalTitleGap: 8,
            leading: Icon(CupertinoIcons.qrcode, color: Colors.black, size: 30),
            title: Text(
              "Мой QR-код",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'PTSans',
                fontWeight: FontWeight.bold,
                fontSize: 14
              )
            ),
          ),
          Divider(color: Colors.grey[600], indent: 8, endIndent: 8, thickness: 0.25, height: 0,),
          const ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            horizontalTitleGap: 8,
            leading: Icon(Icons.settings_suggest_outlined, color: Colors.black, size: 30),
            title: Text(
              "Настройки и конфиденциальность",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'PTSans',
                fontWeight: FontWeight.bold,
                fontSize: 14
              )
            ),
          ),
        ],
      ),
    );
  }

  

  @override
  void dispose() {
    _tabController.dispose();
    print("Video disposed");
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: false,
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          displacement: 0,
          edgeOffset: kToolbarHeight,
          onRefresh: () async {},
          strokeWidth: 2,
          color: Colors.black,
          backgroundColor: Colors.white,
          child: NestedScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  
                  SliverAppBar(
                    stretch: true,
                    bottom: TabBar(
                      indicatorColor: Colors.black,
                      enableFeedback: false,
                      splashFactory: NoSplash.splashFactory,
                      controller: _tabController,
                      tabs: <Tab>[
                        Tab(
                          icon: GestureDetector(
                            onTap: () {
                              if (_tabController.index == 0) {
                                showMenu(
                                  surfaceTintColor: Colors.black,
                                  color: Colors.black.withOpacity(0.6),
                                  popUpAnimationStyle: AnimationStyle(curve: Curves.easeIn, reverseCurve: Curves.fastOutSlowIn),
                                  context: context, 
                                  position: RelativeRect.fromSize(Rect.fromCenter(center: const Offset(-56, 370), width: 100, height: 60), const Size(100, 60)),
                                  items: [
                                    CheckedPopupMenuItem(
                                      
                                      onTap: () {
                                        setState(() {
                                          filterPopular = false;
                                        });
                                      },
                                      height: 30,
                                      checked: !filterPopular,
                                      child: const Text(

                                            "Недавние",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15
                                            )
                                          ),
                                    ),
                                    
                                    CheckedPopupMenuItem(
                                      onTap: () {
                                        setState(() {
                                          filterPopular = true;
                                        });
                                      },
                                      height: 30,
                                      checked: filterPopular,
                                      child: const Text(
                                            "Популярное",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15
                                            )
                                          ),
                                    ),
                                  ]
                                );
                              } else {
                                _tabController.animateTo(0);
                              }
                            },
                            child: tab1
                          ),
                        ),
                        Tab(icon: Icon(CupertinoIcons.lock,  size: 20,color: _tabController.index == 1 ? Colors.black : Colors.black.withOpacity(0.7))),
                        Tab(icon: RotatedBox(quarterTurns: 1, child: Icon(CupertinoIcons.repeat,  size: 20,color: _tabController.index == 2 ? Colors.black : Colors.black.withOpacity(0.7)))),
                        Tab(icon: Icon(CupertinoIcons.bookmark,  size: 20,color: _tabController.index == 3 ? Colors.black : Colors.black.withOpacity(0.7))),
                        Tab(icon: Icon(CupertinoIcons.heart,  size: 20,color: _tabController.index == 4 ? Colors.black : Colors.black.withOpacity(0.7)),
                      )]
                    ),
                    backgroundColor: Colors.white,
                    shadowColor: Colors.transparent,
                    //forceMaterialTransparency: true,
                    primary: true,
                    expandedHeight: 320,
                    //automaticallyImplyLeading: true,
                    leading: widget.fromVideo ? GestureDetector(
                      onTap: () => widget.onBack!(),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded, 
                        color: Colors.black, size: 20)
                      ) : const SizedBox(height: 0, width: 0,),
                    //forceElevated: true,
                    //scrolledUnderElevation: 0,
                    //elevation: 300,
                    collapsedHeight: kToolbarHeight,
                    floating: true,
                    pinned: true,
                    centerTitle: true,
                    actions: [
                      SvgPicture.asset(
                        'assets/images/footprint.svg',
                        width: 20,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context, 
                              builder: (context) => settingsMenu()
                            );
                          },
                          child: const Icon(Icons.menu_rounded,
                              color: Colors.black, size: 20),
                        ),
                      )
                    ],
                    title: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Сашка",
                            maxLines:1, //overflow:TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: 'PTSans')),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
                              context: context, 
                              builder: (context) => Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 8, bottom: 8, right: 16, left: 16),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(width: 15,),
                                        Text(
                                          "Сменить аккаунт", 
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'PTSans',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16
                                          )
                                        ),
                                        Icon(CupertinoIcons.xmark, color: Colors.black, size: 16)
                                      ],
                                    ),
                                  ),
                                  ListTile(
                                    leading: CircleAvatar(
                                      radius: 23,
                                      backgroundColor: Colors.grey.shade800,
                                      child: const Center(child: Icon(CupertinoIcons.person_fill, color: Colors.white, size: 23)),
                                    ),
                                    title: const Text(
                                          "alekstarat", 
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'PTSans',
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15
                                          )
                                        ),
                                    horizontalTitleGap: 12,
                                    trailing: const Icon(CupertinoIcons.check_mark, color: Colors.red, size: 16,),
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                                  ),
                                  ListTile(
                                    leading: CircleAvatar(
                                      radius: 23,
                                      backgroundColor: Colors.grey.shade800,
                                      child: const Center(child: Icon(CupertinoIcons.plus, color: Colors.white, size: 23)),
                                    ),
                                    title: const Text(
                                          "Добавить аккаунт", 
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'PTSans',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15
                                          )
                                        ),
                                    horizontalTitleGap: 12,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                                  )
                                ],
                              )
                            );
                          },
                          child: const Icon(Icons.keyboard_arrow_down_rounded,
                              color: Colors.black, size: 25),
                        )
                      ],
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.pin,
                        expandedTitleScale: 1,
                        stretchModes: const [
                          StretchMode.blurBackground
                        ],
                        background: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(top: 80),
                          children: [
                            Center(
                              child: SizedBox(
                                width: 90,
                                height: 90,
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 45,
                                      backgroundColor: Colors.black.withOpacity(0.7),
                                      child: const Icon(CupertinoIcons.person_solid, color: Colors.white, size: 45,),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.lightBlue[600],
                                          shape: BoxShape.circle,
                                          border: Border.all(color: Colors.white, width: 3)
                                        ),
                                        child: const Center(
                                          child: Icon(Icons.add_rounded, color: Colors.white, size: 20),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 3),
                                child: Text(
                                  "@alekstarat",
                                  style: TextStyle(
                                    letterSpacing: 0,
                                    color: Colors.black,
                                    
                                    fontSize: 15,
                                    fontFamily: 'PTSans')
                                ),
                              ),
                            ),
                                                  
                            Center(
                              child: Stack(                              
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 100),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                            "55",
                                            style: TextStyle(
                                              letterSpacing: 0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              fontFamily: 'PTSans')
                                          ),
                                          Text(
                                            "Подписки",
                                            style: TextStyle(
                                              color: Colors.black.withOpacity(0.7),
                                              letterSpacing: 0,
                                              fontSize: 10,
                                              fontFamily: 'PTSans')
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  //SizedBox(width: 5,),
                                  Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          "467",
                                          style: TextStyle(
                                            letterSpacing: 0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            fontFamily: 'PTSans')
                                        ),
                                        Text(
                                          "Подписчиков",
                                          style: TextStyle(
                                            color: Colors.black.withOpacity(0.7),
                                            letterSpacing: 0,
                                            fontSize: 10,
                                            fontFamily: 'PTSans')
                                        )
                                      ],
                                    ),
                                  ),
                                  
                                  Padding(
                                    padding: const EdgeInsets.only(right: 80),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                            "18,5 тыс.",
                                            style: TextStyle(
                                              letterSpacing: 0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              fontFamily: 'PTSans')
                                          ),
                                          Text(
                                            "Лайки",
                                            style: TextStyle(
                                              color: Colors.black.withOpacity(0.7),
                                              letterSpacing: 0,
                                              fontSize: 10,
                                              fontFamily: 'PTSans')
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                                                  
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.3,
                                      height: kToolbarHeight/2+5,
                                      decoration: BoxDecoration(
                                        color: Colors.blueGrey[50],
                                        borderRadius: BorderRadius.circular(8)
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "Изменить профиль",
                                          style: TextStyle(
                                            letterSpacing: 0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11,
                                            fontFamily: 'PTSans')
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 3,),
                                    Container(
                                      width: MediaQuery.of(context).size.width*0.35,
                                      height: kToolbarHeight/2+5,
                                      decoration: BoxDecoration(
                                        color: Colors.blueGrey[50],
                                        borderRadius: BorderRadius.circular(8)
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "Поделиться профилем",
                                          style: TextStyle(
                                            letterSpacing: 0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11,
                                            fontFamily: 'PTSans')
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 3,),
                                    Container(
                                      width: kToolbarHeight/2+5,
                                      height: kToolbarHeight/2+5,
                                      decoration: BoxDecoration(
                                        color: Colors.blueGrey[50],
                                        borderRadius: BorderRadius.circular(8)
                                      ),
                                      child: const Center(
                                        child: Icon(Icons.person_add_alt_outlined, color: Colors.black, size: 20)
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const Center(
                              child: Text(
                                "https://vk.com/raskrasska",
                                        style: TextStyle(
                                          letterSpacing: 0,
                                          color: Colors.black,
                                          
                                          fontSize: 12,
                                          fontFamily: 'PTSans')
                              ),
                            )
                          ],
                        ),
                        ),
                      ),
                  
                ];
              },
              body: NestedTabBarView(
                    controller: _tabController,
                    children: const [
                      StretchingOverscrollIndicator(axisDirection: AxisDirection.up, child: VideosTab(isHidden: false,)),
                      StretchingOverscrollIndicator(axisDirection: AxisDirection.up, child: VideosTab(isHidden: true,)),
                      StretchingOverscrollIndicator(axisDirection: AxisDirection.up, child: VideosTab(isHidden: false,)),
                      StretchingOverscrollIndicator(axisDirection: AxisDirection.up, child: BookmarkTab()),
                      StretchingOverscrollIndicator(axisDirection: AxisDirection.up, child: VideosTab(isHidden: false,)),
                    ],
                  )
            ),
        ));
  }
}
