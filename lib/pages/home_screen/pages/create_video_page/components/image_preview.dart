import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImagePreview extends StatefulWidget {

  final Image image;

  const ImagePreview({super.key, required this.image});

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {

  int? selectedSound;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: widget.image,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 80),
              child: SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 110,
                    height: kToolbarHeight / 2,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4)
                    ),
                    child: const Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(CupertinoIcons.music_note_2, color: Colors.white, size: 15,),
                          SizedBox(width: 5,),
                          Text(
                            "Добавить муз...",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 16),
              child: SafeArea(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.white,
                      shadows: [Shadow(color: Colors.black, blurRadius: 5)],
                      size: 30
                    )
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 120),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min, 
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8)
                            ),
                            child: const Center(
                              child: Icon(Icons.backspace_rounded, color: Colors.white, size: 20,),
                            ),
                          ),
                          const SizedBox(height: 3,),
                          const Text(
                            "Назад",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              shadows: [Shadow(color: Colors.black, blurRadius: 3)]
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle
                      ),
                      child: const Center(
                        child: Icon(CupertinoIcons.check_mark, color: Colors.black, size: 30,),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            border: Border.all(color: Colors.blueAccent, width: 2),
                            shape: BoxShape.circle
                          ),
                          child: const Icon(CupertinoIcons.person_fill, color: Colors.blueGrey,),
                        ),
                        const SizedBox(height: 3,),
                        const Text(
                          "История",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            shadows: [Shadow(color: Colors.black, blurRadius: 3)]
                          ),
                        )
                      ],
                      
                    )
                  ],
                )
              ),
            )
        ],
      ),
    );
  }
}