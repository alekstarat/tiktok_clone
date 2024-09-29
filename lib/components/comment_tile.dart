import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentTile extends StatelessWidget {

  final DateTime date;
  final String name, text;
  final String? image;
  final bool hasResponse;
  final int likes;

  const CommentTile({super.key, required this.date, required this.name, required this.text, this.image, required this.hasResponse, required this.likes});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 15,
            backgroundColor: Colors.black.withOpacity(0.5),
            child: image != null ? Image.asset(image!) : const Icon(CupertinoIcons.person_fill, color: Colors.white,),
          ),
          isThreeLine: true,
          titleAlignment: ListTileTitleAlignment.titleHeight,
          title: Text(
            name,
            style: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontSize: 12
            )
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          horizontalTitleGap: 8,
          
          //minTileHeight: 55,
          dense: true,
          
          trailing: Padding(
            padding: const EdgeInsets.only(top: 55/2),
            child: SizedBox(
              width: 60,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.favorite_outline_rounded, color: Colors.black.withOpacity(0.7), size: 15),
                      const SizedBox(width: 3,),
                      Text(
                        "$likes",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                        )
                      )
                    ],
                  ),
                  Icon(Icons.thumb_down_alt_outlined, color: Colors.black.withOpacity(0.7), size: 15, opticalSize: 15,)
                ],
              ),
            ),
          ),
          visualDensity: VisualDensity.comfortable,
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.normal
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${DateTime.now().difference(date).inMinutes.toString()} м.",
                    style: TextStyle(
                      color: Colors.grey.withOpacity(0.7),
                      fontSize: 10
                    )
                  ),
                  const SizedBox(width: 8,),
                  Text(
                    "Ответить",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 10,
                      fontWeight: FontWeight.bold
                    )
                  )
                ],
              )
            ],
          ),
        ),
        if (hasResponse) Padding(
          padding: const EdgeInsets.only(left: 46),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 14,
                height: 0.5,
                color: Colors.black.withOpacity(0.7),
              ),
              const SizedBox(width: 5),
              Text(
                    "Показать 11 ответов",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 10,
                      fontWeight: FontWeight.bold
                    )
                  )
            ],
          ),
        )
      ],
    );
  }
}