import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RepostWidgetTile extends StatelessWidget {

  final IconData icon;
  final String text;
  final Color? color, iconColor;


  const RepostWidgetTile({super.key, required this.icon, required this.text, required this.color, this.iconColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
                    width: 70,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          backgroundColor: color,
                          radius: 25,
                          child: Center(
                            child: Icon(icon, color: iconColor, grade: -25,),
                          ),
                        ),
                        Text(
                          text,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.black
                          ),
                        )
                      ],
                    ),
                  );
  }
}