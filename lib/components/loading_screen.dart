import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  double opacity = 0.1;
  bool isActive = false, isSuccess = false;

  void complete() {
    setState(() {
      isSuccess = true;
    });
  }

  void loading() {
    setState(() {
      isActive = !isActive;
    });
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          isActive = !isActive;
        });
      }
      
    });
  }

  @override
  void initState() {
    super.initState();
    loading();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedOpacity(
        duration: const Duration(seconds: 2),
        opacity: isSuccess ? 0.8 : isActive ? 0.6 : 0.1,
        curve: Curves.decelerate,
        onEnd: () => loading(),
        child: Image.asset(
          'assets/images/BCLogo.png', 
          filterQuality: FilterQuality.high,
          width: 170,
        ),
      )
    );
  }
}