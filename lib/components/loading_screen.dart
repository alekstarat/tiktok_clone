import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double opacity = 0.5;

  void toggleOpacity() {
    if (opacity == 0.5) {
      setState(() {
        opacity = 1;
      });
      Future.delayed(const Duration(seconds: 3), () => toggleOpacity());
    } else {
      setState(() {
        opacity = 0.5;
      });
      Future.delayed(const Duration(seconds: 3), () => toggleOpacity());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - kToolbarHeight + 10,
      color: Colors.black,
      child: Center(
        child: AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(seconds: 0),
          child: SvgPicture.asset('assets/images/BC.svg', width: 150,),
        ),
      ),
    );
  }
}