import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tiktok_clone/components/comment_tile.dart';

class CommentsWidget extends StatelessWidget {

  //final FocusNode focusNode;

  final List<dynamic> comments;

  const CommentsWidget({super.key, required this.comments});

  static const List<String> icons = [
    'assets/icons/emodji_big_long_mouth.svg', 
    'assets/icons/emoji_;P.svg', 
    'assets/icons/emoji_excited.svg', 
    'assets/icons/emoji_glasses_kiss.svg', 
    'assets/icons/emoji_gore.svg',
    'assets/icons/emoji_love.svg',
    'assets/icons/emoji_shock.svg',
    'assets/icons/emoji_silent.svg',
    'assets/icons/emoji_smirk.svg',
    'assets/icons/emoji_upset.svg'
  ];

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
                Text(
                  comments.length.toString() + (int.parse(comments.length.toString()[0]) == 0 ? " комментариев" : (int.parse(comments.length.toString()[0]) <= 4 ? " комментария" : " комментариев")),
                  style: const TextStyle(
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
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  return CommentTile(date: comments[index].date, name: "Ебалбек", text: "nike pro", hasResponse: false, likes: 0);
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
                  itemCount: icons.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    return SvgPicture.asset(icons[index]);
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
                          //focusNode: focusNode,
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