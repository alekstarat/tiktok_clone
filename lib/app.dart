import 'package:flutter/material.dart';
import 'package:tiktok_clone/pages/home_screen/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        splashColor: Colors.transparent,
        fontFamily: 'PTSans'
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}