import 'package:flutter/material.dart';

class LoadingCircleAnimation extends StatefulWidget {
  const LoadingCircleAnimation({super.key});

  @override
  State<LoadingCircleAnimation> createState() => _LoadingCircleAnimationState();
}

class _LoadingCircleAnimationState extends State<LoadingCircleAnimation> with TickerProviderStateMixin {

  late final AnimationController _controller1;
  late final AnimationController _controller2;
  late Animation<double> sizeAnimation1, sizeAnimation2, positionAnimation1;

  @override
  void initState() {
    super.initState();
    _controller1 = AnimationController(vsync: this, duration: const Duration(milliseconds: 350));
    _controller2 = AnimationController(vsync: this, duration: const Duration(milliseconds: 350));

    sizeAnimation1 = Tween<double>(begin: 1.5, end: 1).animate(_controller1)..addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    sizeAnimation2 = Tween<double>(begin: 1.5, end: 1).animate(_controller2)..addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    positionAnimation1 = Tween<double>(begin: 0, end: 20).animate(_controller1)..addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    _controller1.repeat(reverse: true);
    _controller2.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 30,
        height: 15,
        child: Stack(
          //mainAxisSize: MainAxisSize.min,
          children: [
            Positioned(
              right: positionAnimation1.value,
              child: Container(
                width: 10 * sizeAnimation1.value,
                height: 10 * sizeAnimation1.value,
                decoration: BoxDecoration(
                  color: Colors.red[500]!.withOpacity(0.8),
                  shape: BoxShape.circle
                ),
              ),
            ),
            Positioned(
              left: positionAnimation1.value,
              child: Container(
                width: 10 * sizeAnimation2.value,
                height: 10 * sizeAnimation2.value,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.8),
                  shape: BoxShape.circle
                ),
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}