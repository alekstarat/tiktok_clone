import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IconTile extends StatelessWidget {

  final IconData icon;
  final String text;

  const IconTile({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 25, color: Colors.white, shadows: const [Shadow(color: Colors.black, blurRadius: 3)],),
        const SizedBox(height: 5,),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            shadows: [Shadow(color: Colors.white, blurRadius: 3)]
          ),
        )
      ],
    );
  }
}