import 'package:flutter/material.dart';
import 'package:tiktok_clone/components/loading_screen.dart';

class SubscriptionsTab extends StatelessWidget {
  const SubscriptionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - kToolbarHeight + 10,
      child: LoadingScreen(),
    );
  }
}