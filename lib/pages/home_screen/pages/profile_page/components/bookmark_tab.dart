import 'package:flutter/material.dart';
import 'package:nested_scroll_views/material.dart';

class BookmarkTab extends StatefulWidget {
  const BookmarkTab({super.key});

  @override
  State<BookmarkTab> createState() => _BookmarkTabState();
}

class _BookmarkTabState extends State<BookmarkTab> with TickerProviderStateMixin {

  late final TabController _nestedController;

  final TextStyle selectedStyle = const TextStyle(
    color: Colors.black,
    fontFamily: 'PTSans',
    fontWeight: FontWeight.bold,
    fontSize: 14
  );

  final TextStyle usselectedStyle = TextStyle(
    color: Colors.grey[600],
    fontFamily: 'PTSans',
    fontWeight: FontWeight.bold,
    fontSize: 13
  );

  @override
  void initState() {
    super.initState();
    _nestedController = TabController(length: 12, vsync: this);
  }

  @override
  void dispose() {
    _nestedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TabBar(
        enableFeedback: false,
        splashFactory: NoSplash.splashFactory,
        padding: EdgeInsets.zero,
        indicatorColor: Colors.transparent,
        isScrollable: true,
            controller: _nestedController,
            labelStyle: selectedStyle,
            unselectedLabelStyle: usselectedStyle,
            tabs: const [
              Tab(text: "Публикации", height: 30,),
              Tab(text: "Коллекции", height: 30,),
              Tab(text: "Музыка", height: 30,),
              Tab(text: "Эффекты", height: 30,),
              Tab(text: "Товары", height: 30,),
              Tab(text: "Места", height: 30,),
              Tab(text: "Плейлисты", height: 30,),
              Tab(text: "Фильмы и сериалы", height: 30,),
              Tab(text: "Книги", height: 30,),
              Tab(text: "Комментарии", height: 30,),
              Tab(text: "Хэштеги", height: 30,),
              Tab(text: "TikTok Series", height: 30,),
            ]
          ),
      body: NestedTabBarView(
            controller: _nestedController,
            children: [
              Container(),
              Container(),
              Container(),
              Container(),
              Container(),
              Container(),
              Container(),
              Container(),
              Container(),
              Container(),
              Container(),
              Container(),
            ]
          )
    );
  }
}