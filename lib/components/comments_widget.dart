import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/components/comment_tile.dart';

class CommentsWidget extends StatelessWidget {
  const CommentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.5,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 17,
                ),
                const Text(
                  "52 комментария",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.1
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    CupertinoIcons.xmark, 
                    color: Colors.black, 
                    size: 17, 
                    grade: -25,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/2 - 3*(kToolbarHeight/1.5)-10,
              
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 16),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return CommentTile(date: DateTime.now(), name: "Ебалбек", text: "nike pro", hasResponse: true, likes: 52);
                }
              ),
            ),
          ),
          Column(
            children: [
              Divider(color: Colors.grey.shade400, height: 0, thickness: 0),
              SizedBox(
                height: kToolbarHeight/1.5,
                width: MediaQuery.of(context).size.width,
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(width: 16,),
                  scrollDirection: Axis.horizontal,
                  itemCount: 20,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    return const Icon(Icons.emoji_emotions, color: Colors.black, size: 30);
                  }
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4, right: 8, left: 8),
                child: SizedBox(
                  height: kToolbarHeight/1.5,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Color(0xFFB57B7B),
                        radius: 15,
                        child: Icon(CupertinoIcons.person_fill, color: Colors.white),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width-52,
                        height: 30,
                        child: CupertinoTextField(
                          cursorColor: Colors.red,
                          cursorWidth: 1,
                          
                          placeholder: "Добавить комментарий...",
                          placeholderStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey.withOpacity(0.5)
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(90),
                          
                          ),
                          
                          suffix: const Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: SizedBox(
                              width: 80,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.alternate_email_rounded, color: Colors.black,),
                                  Icon(Icons.emoji_emotions_outlined),
                                  Icon(CupertinoIcons.gift, color: Colors.black, size: 21,)
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom,)
            ],
          ),
          
        ],
      ),
    );
  }
}