// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nested_scroll_views/material.dart';
import 'package:tiktok_clone/api/api_service_impl.dart';
import 'package:tiktok_clone/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:tiktok_clone/auth/pages/auth_page.dart';
import 'package:tiktok_clone/packages/auth_repository/auth_repository_impl.dart';
import 'package:tiktok_clone/packages/models/user_model.dart';
import 'package:tiktok_clone/packages/user_repository/user_repository_impl.dart';
import 'package:tiktok_clone/pages/home_screen/pages/profile_page/components/bookmark_tab.dart';
import 'package:tiktok_clone/pages/home_screen/pages/profile_page/components/videos_tab.dart';
import 'package:tiktok_clone/pages/home_screen/pages/profile_page/pages/settings_page.dart';

class ProfilePage extends StatefulWidget {
  final int id;
  final bool fromVideo;
  final Function? onBack;

  const ProfilePage(
      {super.key, required this.id, required this.fromVideo, this.onBack});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final TabController _tabController;
  late final Widget tab1;
  UserModel? usr;
  bool filterPopular = false;
  bool isMyProfile = false;
  bool isSubscribed = false;

  double currentExtent = 0.0;

  void getUser() async {
    try {
      if (widget.fromVideo || widget.id != context.read<UserRepository>().userId) {
        await ApiServiceImpl().getAuthenticatedUser(widget.id).then((v) {
          setState(() {
            usr = v;
            isSubscribed = context.read<UserRepository>().user!.subscriptions.contains(usr!.id);
            print("isSubscribed: $isSubscribed");
            print(v);
          });
        });
      } else {
        setState(() {
          usr = context.read<UserRepository>().user;
        });
      }
    } catch (e) {
      print(e.toString());
    }
    
    
  }

  @override
  void initState() {
    super.initState();
    getUser();
    isMyProfile = widget.id == context.read<UserRepository>().userId;
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
                      : Colors.black.withOpacity(0.7)),
            ),
          ),
          const Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.arrow_drop_down_rounded,
                size: 25,
                color: Colors.black,
              ))
        ],
      ),
    );
  }

  Widget settingsMenu() {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            horizontalTitleGap: 8,
            leading: Icon(CupertinoIcons.person_crop_circle_badge_plus,
                color: Colors.black, size: 30),
            title: Text("Инструменты автора",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'PTSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 14)),
          ),
          Divider(
            color: Colors.grey[600],
            indent: 8,
            endIndent: 8,
            thickness: 0.25,
            height: 0,
          ),
          const ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            horizontalTitleGap: 8,
            leading: Icon(CupertinoIcons.qrcode, color: Colors.black, size: 30),
            title: Text("Мой QR-код",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'PTSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 14)),
          ),
          Divider(
            color: Colors.grey[600],
            indent: 8,
            endIndent: 8,
            thickness: 0.25,
            height: 0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => BlocProvider(
                            create: (_) => AuthBloc(userRepo: context.read<UserRepository>(), authRepo: context.read<AuthRepository>()),
                            child: const SettingsPage(),
          
                          )));
            },
            child: const ListTile(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              horizontalTitleGap: 8,
              leading: Icon(Icons.settings_suggest_outlined,
                  color: Colors.black, size: 30),
              title: Text("Настройки и конфиденциальность",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'PTSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 14)),
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
    super.build(context);
    return RepositoryProvider(
      create: (_) => context.read<UserRepository>(),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthenticatedState || widget.fromVideo) {
            //var usr = context.read<UserRepository>().user!;
            //var usr = ApiServiceImpl().getAuthenticatedUser(widget.id);
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
                                                color: Colors.black
                                                    .withOpacity(0.6),
                                                popUpAnimationStyle:
                                                    AnimationStyle(
                                                        curve: Curves.easeIn,
                                                        reverseCurve: Curves
                                                            .fastOutSlowIn),
                                                context: context,
                                                position: RelativeRect.fromSize(
                                                    Rect.fromCenter(
                                                        center: const Offset(
                                                            -56, 370),
                                                        width: 100,
                                                        height: 60),
                                                    const Size(100, 60)),
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
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15)),
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
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15)),
                                                  ),
                                                ]);
                                          } else {
                                            _tabController.animateTo(0);
                                          }
                                        },
                                        child: tab1),
                                  ),
                                  Tab(
                                      icon: Icon(CupertinoIcons.lock,
                                          size: 20,
                                          color: _tabController.index == 1
                                              ? Colors.black
                                              : Colors.black.withOpacity(0.7))),
                                  Tab(
                                      icon: RotatedBox(
                                          quarterTurns: 1,
                                          child: Icon(CupertinoIcons.repeat,
                                              size: 20,
                                              color: _tabController.index == 2
                                                  ? Colors.black
                                                  : Colors.black
                                                      .withOpacity(0.7)))),
                                  Tab(
                                      icon: Icon(CupertinoIcons.bookmark,
                                          size: 20,
                                          color: _tabController.index == 3
                                              ? Colors.black
                                              : Colors.black.withOpacity(0.7))),
                                  Tab(
                                    icon: Icon(CupertinoIcons.heart,
                                        size: 20,
                                        color: _tabController.index == 4
                                            ? Colors.black
                                            : Colors.black.withOpacity(0.7)),
                                  )
                                ]),
                            backgroundColor: Colors.white,
                            shadowColor: Colors.transparent,
                            //forceMaterialTransparency: true,
                            primary: true,
                            expandedHeight: 320,
                            //automaticallyImplyLeading: true,
                            leading: widget.fromVideo
                                ? GestureDetector(
                                    onTap: () => widget.onBack!(),
                                    child: const Icon(
                                        Icons.arrow_back_ios_new_rounded,
                                        color: Colors.black,
                                        size: 20))
                                : const SizedBox(
                                    height: 0,
                                    width: 0,
                                  ),
                            //forceElevated: true,
                            //scrolledUnderElevation: 0,
                            //elevation: 300,
                            collapsedHeight: kToolbarHeight,
                            floating: true,
                            pinned: true,
                            centerTitle: true,
                            actions: [
                              isMyProfile ? SvgPicture.asset(
                                'assets/images/footprint.svg',
                                width: 20,
                                color: Colors.black,
                              ) : const Icon(Icons.notifications_none_rounded, color: Colors.black, size: 20,),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: isMyProfile ? GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (context) => settingsMenu());
                                  },
                                  child: const Icon(Icons.menu_rounded,
                                      color: Colors.black, size: 20),
                                ) : const Icon(CupertinoIcons.arrowshape_turn_up_right, color: Colors.black, size: 20,),
                              )
                            ],
                            title: isMyProfile ? Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(usr != null ? usr!.name! : "",
                                    maxLines:
                                        1, //overflow:TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        fontFamily: 'PTSans')),
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(12))),
                                        context: context,
                                        builder: (context) => Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 8,
                                                      bottom: 8,
                                                      right: 16,
                                                      left: 16),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      Text("Сменить аккаунт",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  'PTSans',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16)),
                                                      Icon(CupertinoIcons.xmark,
                                                          color: Colors.black,
                                                          size: 16)
                                                    ],
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: CircleAvatar(
                                                    radius: 23,
                                                    backgroundColor:
                                                        Colors.grey.shade800,
                                                    child: const Center(
                                                        child: Icon(
                                                            CupertinoIcons
                                                                .person_fill,
                                                            color: Colors.white,
                                                            size: 23)),
                                                  ),
                                                  title: Text(
                                                      usr != null ? usr!.login : "",
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: 'PTSans',
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 15)),
                                                  horizontalTitleGap: 12,
                                                  trailing: const Icon(
                                                    CupertinoIcons.check_mark,
                                                    color: Colors.red,
                                                    size: 16,
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 16,
                                                          vertical: 2),
                                                ),
                                                ListTile(
                                                  leading: CircleAvatar(
                                                    radius: 23,
                                                    backgroundColor:
                                                        Colors.grey.shade800,
                                                    child: const Center(
                                                        child: Icon(
                                                            CupertinoIcons.plus,
                                                            color: Colors.white,
                                                            size: 23)),
                                                  ),
                                                  title: const Text(
                                                      "Добавить аккаунт",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: 'PTSans',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15)),
                                                  horizontalTitleGap: 12,
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 16,
                                                          vertical: 2),
                                                )
                                              ],
                                            ));
                                  },
                                  child: const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: Colors.black,
                                      size: 25),
                                )
                              ],
                            ) : null,
                            flexibleSpace: FlexibleSpaceBar(
                              collapseMode: CollapseMode.pin,
                              expandedTitleScale: 1,
                              stretchModes: const [StretchMode.blurBackground],
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
                                            backgroundColor:
                                                Colors.black.withOpacity(0.7),
                                            child: usr != null ? usr!.image == null ||
                                                    usr!.image == ""
                                                ? const Icon(
                                                    CupertinoIcons.person_solid,
                                                    color: Colors.white,
                                                    size: 45,
                                                  )
                                                : Center(
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              90),
                                                      child: Image.network(
                                                          'http://10.0.2.2:8000/image/${usr!.image}'),
                                                    ),
                                                  ) : const Icon(
                                                    CupertinoIcons.person_solid,
                                                    color: Colors.white,
                                                    size: 45,
                                                  ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: isMyProfile ? Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                  color: Colors.lightBlue[600],
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 3)),
                                              child: const Center(
                                                child: Icon(Icons.add_rounded,
                                                    color: Colors.white,
                                                    size: 20),
                                              ),
                                            ) : null,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.symmetric(vertical: 3),
                                      child: Text(usr != null ? "@${usr!.login}" : "",
                                          style: const TextStyle(
                                              letterSpacing: 0,
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontFamily: 'PTSans')),
                                    ),
                                  ),
                                  Center(
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 100),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                    usr != null ? usr!.subscriptions.length
                                                        .toString() : "",
                                                    style: const TextStyle(
                                                        letterSpacing: 0,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                        fontFamily: 'PTSans')),
                                                Text("Подписки",
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.7),
                                                        letterSpacing: 0,
                                                        fontSize: 10,
                                                        fontFamily: 'PTSans'))
                                              ],
                                            ),
                                          ),
                                        ),
                                        //SizedBox(width: 5,),
                                        Center(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                  usr != null ? usr!.subscribers.length
                                                      .toString() : "",
                                                  style: const TextStyle(
                                                      letterSpacing: 0,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                      fontFamily: 'PTSans')),
                                              Text("Подписчиков",
                                                  style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.7),
                                                      letterSpacing: 0,
                                                      fontSize: 10,
                                                      fontFamily: 'PTSans'))
                                            ],
                                          ),
                                        ),

                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 80),
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text('0',
                                                    style: TextStyle(
                                                        letterSpacing: 0,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18,
                                                        fontFamily: 'PTSans')),
                                                Text("Лайки",
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.7),
                                                        letterSpacing: 0,
                                                        fontSize: 10,
                                                        fontFamily: 'PTSans'))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: isMyProfile ? Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            height: kToolbarHeight / 2 + 5,
                                            decoration: BoxDecoration(
                                                color: Colors.blueGrey[50],
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: const Center(
                                              child: Text("Изменить профиль",
                                                  style: TextStyle(
                                                      letterSpacing: 0,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 11,
                                                      fontFamily: 'PTSans')),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.35,
                                            height: kToolbarHeight / 2 + 5,
                                            decoration: BoxDecoration(
                                                color: Colors.blueGrey[50],
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: const Center(
                                              child: Text("Поделиться профилем",
                                                  style: TextStyle(
                                                      letterSpacing: 0,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 11,
                                                      fontFamily: 'PTSans')),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          Container(
                                            width: kToolbarHeight / 2 + 5,
                                            height: kToolbarHeight / 2 + 5,
                                            decoration: BoxDecoration(
                                                color: Colors.blueGrey[50],
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: const Center(
                                                child: Icon(
                                                    Icons
                                                        .person_add_alt_outlined,
                                                    color: Colors.black,
                                                    size: 20)),
                                          )
                                        ],
                                      ) : Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(height: 3,),
                                          GestureDetector(
                                            onTap: () async {
                                              await context.read<UserRepository>().subscribe(context.read<UserRepository>().userId!, widget.id);
                                              await context.read<UserRepository>().getAuthenticatedUser(widget.id).then((v) {
                                                setState(() {
                                                  usr = v!;
                                                  isSubscribed = true;
                                                });
                                              });
                                              context.read<UserRepository>().refreshUserData();
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: !isSubscribed ? Colors.red[600] : Colors.grey[300],
                                                borderRadius: BorderRadius.circular(6)
                                              ),
                                              width: 100,
                                              height: kToolbarHeight/ 2 + 5,
                                              child: !isSubscribed ? const Center(
                                                child: Text(
                                                  "Подписаться",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12
                                                  ),
                                                ),
                                              ) : const Center(
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Icon(CupertinoIcons.paperplane_fill, color: Colors.black, size: 15),
                                                    Text(
                                                      "Сообщение",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 12
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (isSubscribed) const SizedBox(width: 3,),
                                          if (isSubscribed) GestureDetector(
                                            onTap: () async {
                                              await context.read<UserRepository>().unsubscribe(context.read<UserRepository>().userId!, widget.id);
                                              await context.read<UserRepository>().getAuthenticatedUser(widget.id).then((v) {
                                                setState(() {
                                                  usr = v!;
                                                  isSubscribed = false;
                                                });
                                              });
                                              context.read<UserRepository>().refreshUserData();
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius: BorderRadius.circular(6)
                                              ),
                                              width: kToolbarHeight / 2 + 5,
                                              height: kToolbarHeight / 2 + 5,
                                              child: const Center(
                                                child: Icon(CupertinoIcons.person_badge_minus_fill, color: Colors.black, size: 15),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 3,),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius: BorderRadius.circular(6)
                                            ),
                                            width: kToolbarHeight / 2 + 5,
                                            height: kToolbarHeight / 2 + 5,
                                            child: const Center(
                                              child: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black, size: 15),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(usr != null ? usr!.description ?? "" : "",
                                        style: const TextStyle(
                                            letterSpacing: 0,
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontFamily: 'PTSans')),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ];
                      },
                      body: NestedTabBarView(
                        controller: _tabController,
                        children: [
                          StretchingOverscrollIndicator(
                              axisDirection: AxisDirection.up,
                              child: VideosTab(
                                videos: usr != null ? List.generate(
                                    usr!.videos.length, (i) => usr!.videos[i]) : [],
                                isHidden: false,
                              )),
                          const StretchingOverscrollIndicator(
                              axisDirection: AxisDirection.up,
                              child: VideosTab(
                                videos: [],
                                isHidden: true,
                              )),
                          StretchingOverscrollIndicator(
                              axisDirection: AxisDirection.up,
                              child: VideosTab(
                                videos: usr != null ? List.generate(
                                    usr!.reposts.length, (i) => usr!.reposts[i]) : [],
                                isHidden: false,
                              )),
                          const StretchingOverscrollIndicator(
                              axisDirection: AxisDirection.up,
                              child: BookmarkTab()),
                          StretchingOverscrollIndicator(
                              axisDirection: AxisDirection.up,
                              child: VideosTab(
                                videos: usr != null ? List.generate(usr!.likedVideos.length,
                                    (i) => usr!.likedVideos[i]) : [],
                                isHidden: false,
                              )),
                        ],
                      )),
                ));
          } else {
            return BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                print("isClosed: ${context.read<AuthBloc>().isClosed}");
                return Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: const Text('Профиль',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  body: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          CupertinoIcons.person,
                          color: Colors.black.withOpacity(0.4),
                          size: 100,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Войти в существующий аккаунт',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return BlocProvider.value(
                                value: AuthBloc(
                                    authRepo: context.read<AuthRepository>(),
                                    userRepo: context.read<UserRepository>()),
                                child: const AuthPage(),
                              );
                            }));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.red[600],
                                borderRadius: BorderRadius.circular(8)),
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: kToolbarHeight / 1.1,
                            child: const Center(
                              child: Text(
                                "Войти",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 256,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
