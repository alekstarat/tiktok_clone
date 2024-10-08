import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/components/repost_widget_tile.dart';

class RepostWidget extends StatelessWidget {
  const RepostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    "Поделиться",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      CupertinoIcons.xmark,
                      color: Colors.black,
                      size: 15
                    ),
                  ),
                  
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 80,
              child: ListView(
                
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                children: [
                  RepostWidgetTile(icon: CupertinoIcons.search, text: "Ещё", color: Colors.grey[300], iconColor: Colors.black,),
                  RepostWidgetTile(icon: CupertinoIcons.person_add, text: "Пригласить друзей", color: Colors.purple[700])
                ],
              ),
            ),
            Divider(height: 32, color: Colors.grey[400], thickness: 0.5,),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  RepostWidgetTile(icon: CupertinoIcons.repeat, text: "Репост", color: Colors.yellow[600]),
                  const RepostWidgetTile(icon: CupertinoIcons.paperplane_fill, text: "Telegram", color: Colors.blue),
                  const RepostWidgetTile(icon: CupertinoIcons.phone_circle, text: "WhatsApp", color: Colors.green),
                  RepostWidgetTile(icon: CupertinoIcons.chat_bubble_fill, text: "SMS", color: Colors.green[400]),
                  const RepostWidgetTile(icon: CupertinoIcons.mail_solid, text: "Почта", color: Colors.blueAccent)
                ],
              )
            ),
            const SizedBox(height: 8,),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 70,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  RepostWidgetTile(icon: CupertinoIcons.flag_fill, text: "Жалоба", color: Colors.grey[300], iconColor: Colors.black,),
                  RepostWidgetTile(icon: CupertinoIcons.heart_slash_fill, text: "Неинтересно", color: Colors.grey[300], iconColor: Colors.black,),
                  RepostWidgetTile(icon: CupertinoIcons.arrow_down_to_line, text: "Скачать видео", color: Colors.grey[300], iconColor: Colors.black,)
                ],
              )
            ),
          ],
          
        ),
      ),
    );
  }
}