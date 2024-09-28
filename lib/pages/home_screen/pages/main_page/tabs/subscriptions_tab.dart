import 'package:flutter/material.dart';

class SubscriptionsTab extends StatelessWidget {
  const SubscriptionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - kToolbarHeight + 10,
    );
  }
}