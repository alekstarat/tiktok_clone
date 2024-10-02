import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class VideoTile extends StatelessWidget {

  final int id;
  final bool isHidden;

  const VideoTile({super.key, required this.id, required this.isHidden});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
        ),
        const Padding(
          padding: EdgeInsets.all(2.0),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.play_arrow_outlined, color: Colors.white, size: 15),
                Text(
                  "228",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'PTSans',
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0
                  )
                )
              ],
            ),
          ),
        ),
        if (isHidden) const Padding(
          padding: EdgeInsets.all(2.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Icon(
              CupertinoIcons.lock, 
              color: Colors.white, 
              size: 15
            ),
          ),
        )
      ],
    );
  }
}