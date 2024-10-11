// ignore_for_file: use_build_context_synchronously
import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tiktok_clone/components/loading_circle_animation.dart';
import 'package:tiktok_clone/pages/home_screen/pages/create_video_page/components/image_preview.dart';
import 'package:neon_circular_timer/neon_circular_timer.dart';
import 'package:tiktok_clone/pages/home_screen/pages/create_video_page/components/video_preview.dart';

class MyTimer extends StatelessWidget {

  final CountDownController controller;
  final int duraiton;
  final Function onComplete;

  const MyTimer({super.key, required this.controller, required this.duraiton, required this.onComplete});

  CountDownController get controlle => controller;

  void start() {
    controller.start();
  }

  void pause() {
    controller.pause();
  }

  void resume() {
    controller.resume();
  }

  void restart() {
    controller.restart();
  }

  @override
  Widget build(BuildContext context) {
    return NeonCircularTimer(
        width: 90,
        autoStart: false,
        backgroundColor: Colors.transparent,
        isReverse: false,
        strokeWidth: 5,
        strokeCap: StrokeCap.square,
        outerStrokeColor: Colors.transparent,
        neon: 0,
        neonColor: Colors.redAccent,
        duration: duraiton,
        textStyle: const TextStyle(color: Colors.transparent),
        initialDuration: 0,
        controller: controller,
        onComplete: () => onComplete(),
      );
  }
}

class CreateVideoPage extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CreateVideoPage({super.key, required this.cameras});

  @override
  State<CreateVideoPage> createState() => _CreateVideoPageState();
}

class _CreateVideoPageState extends State<CreateVideoPage>
    with TickerProviderStateMixin {
  late CameraController _controller;
  final List<String> pages = ["Опубликовать", "История", "Темы"];
  int carouselIndex1 = 0, carouselIndex2 = 3;
  int currCameraIdx = 0;
  bool isRecording = false, isLoading = false;
  bool hasRecordedVideo = false, hasFullRecord = false;
  double progressIndicatorValue = 0;
  

  XFile? recordedVideo;

  late final List<MyTimer> timersList;

  MyTimer? _timer;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void initCamera() async {
    _controller =
        CameraController(widget.cameras[currCameraIdx], ResolutionPreset.max);
    await _controller.initialize().then((value) async {
      if (!mounted) {
        return;
      }
      await _controller.prepareForVideoRecording();
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    timersList = [
      MyTimer(duraiton: 600, controller: CountDownController(), onComplete: () {
        _controller.pauseVideoRecording();
        timersList[carouselIndex2].restart();
        setState(() {
          isRecording = false;
          hasRecordedVideo = true;
          hasFullRecord = true;
        });
      },), 
      MyTimer(duraiton: 60, controller: CountDownController(), onComplete: () {
        _controller.pauseVideoRecording();
        timersList[carouselIndex2].restart();
        setState(() {
          isRecording = false;
          hasRecordedVideo = true;
          hasFullRecord = true;
        });
      }), 
      MyTimer(duraiton: 15, controller: CountDownController(),onComplete: () {
        if (_controller.value.isRecordingVideo) {
          _controller.pauseVideoRecording();
        }
        setState(() {
          isRecording = false;
          hasRecordedVideo = true;
          hasFullRecord = true;
        });
        
      }), 
    ];
    _timer = timersList[2];
    initCamera();
    print(widget.cameras);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: _controller.value.isInitialized
                ? CameraPreview(_controller)
                : const LoadingCircleAnimation(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 100,
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedOpacity(
                    opacity:
                        (carouselIndex1 != 0 || isRecording) || hasRecordedVideo
                            ? 0
                            : 1,
                    duration: const Duration(milliseconds: 100),
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                            height: 20,
                            width:
                                [60, 50, 45, 50, 50][carouselIndex2].toDouble(),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(90),
                                color: Colors.white),
                          ),
                        ),
                        CarouselSlider.builder(
                            itemCount: 5,
                            itemBuilder: (context, index, realIndex) {
                              return Text(
                                [
                                  '10 мин',
                                  '60 с',
                                  '15 с',
                                  'Фото',
                                  'Текст'
                                ][index],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: index != carouselIndex2
                                        ? Colors.white.withOpacity(0.9)
                                        : Colors.black,
                                    shadows: [
                                      index != carouselIndex2
                                          ? const Shadow(
                                              color: Colors.black,
                                              blurRadius: 3)
                                          : const Shadow(
                                              color: Colors.transparent)
                                    ]),
                              );
                            },
                            options: CarouselOptions(
                              height: 30,
                              initialPage: 3,
                              viewportFraction: 0.15,
                              enableInfiniteScroll: false,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  carouselIndex2 = index;
                                  if (index <= 2) {
                                    _timer = timersList[index];
                                  }
                                  
                                  // if ([0, 1, 2].contains(carouselIndex2)) {
                                  //   timerControllerList[index].restart();
                                  //   timerControllerList[index].pause();
                                  // }
                                  print([
                                    '10 мин',
                                    '60 с',
                                    '15 с',
                                    'Фото',
                                    'Текст'
                                  ][index]);
                                });
                              },
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 64),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 100),
                          opacity: isRecording || hasRecordedVideo ? 0 : 1,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.black),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child:
                                      Image.asset('assets/images/effects.jpg'),
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              const Text(
                                "Эффекты",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 12),
                              )
                            ],
                          ),
                        ),
                        AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            width: !isRecording ? 60 : 90,
                            height: !isRecording ? 60 : 90,
                            decoration: BoxDecoration(
                                border: !isRecording && !hasRecordedVideo
                                    ? Border.all(color: Colors.white, width: 3)
                                    : null,
                                shape: BoxShape.circle,
                                color: !isRecording
                                    ? Colors.transparent
                                    : Colors.grey.withOpacity(0.5)),
                            child: Center(
                              child: GestureDetector(
                                onTap: () async {
                                  if ([0, 1, 2].contains(carouselIndex2)) {
                                    if (!hasFullRecord) {
                                      if (!isRecording && !hasRecordedVideo) {
                                        _controller.startVideoRecording();
                                      } else {
                                        _controller.pauseVideoRecording();
                                        setState(() {
                                          hasRecordedVideo = true;
                                        });
                                      }

                                      setState(() {
                                        isRecording = !isRecording;
                                        try {
                                          isRecording ? hasRecordedVideo ? _timer!.resume() : _timer!.start() : _timer!.pause();
                                        } catch (e) {
                                          print(e.toString());
                                        }
                                      });
                                    } else {
                                      _timer!.restart();
                                    }
                                    
                                  } else {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    var pic = await _controller.takePicture();
                                    var bytes = await  pic.readAsBytes();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ImagePreview(
                                                image: Image.memory(bytes))));
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                },
                                child: Stack(
                                  fit: StackFit.passthrough,
                                  children: [
                                    AnimatedOpacity(
                                      duration:
                                          const Duration(milliseconds: 50),
                                      //opacity: 1,
                                      opacity: isRecording || hasRecordedVideo ? 1 : 0,
                                      child: SizedBox(
                                          width: 90, 
                                          height: 90, 
                                          child: _timer
                                        ),
                                    ),
                                    Center(
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 100),
                                        width: !isRecording ? 50 : 35,
                                        height: !isRecording ? 50 : 35,
                                        decoration: BoxDecoration(
                                            color: [0, 1, 2]
                                                    .contains(carouselIndex2)
                                                ? !isRecording
                                                    ? Colors.redAccent
                                                    : Colors.white
                                                : Colors.white,
                                            gradient: carouselIndex1 == 1
                                                ? const LinearGradient(
                                                    colors: [
                                                        Colors.blue,
                                                        Colors.lightBlue
                                                      ],
                                                    transform: GradientRotation(
                                                        pi / 4))
                                                : null,
                                            shape: BoxShape.circle),
                                        child: isRecording
                                            ? Center(
                                                child: Container(
                                                  width: 15,
                                                  height: 15,
                                                  decoration: BoxDecoration(
                                                      color: Colors.redAccent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                ),
                                              )
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 100),
                          opacity: isRecording || hasRecordedVideo ? 0 : 1,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              const Text(
                                "Загрузить",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 100),
            opacity: hasRecordedVideo && !isRecording ? 1 : 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 100),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.backspace_rounded, color: Colors.white, size: 25, shadows: [Shadow(color: Colors.black, blurRadius: 3)],),
                    const SizedBox(width: 16,),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await _controller.stopVideoRecording().then((v) {
                          // setState(() {
                          //   recordedVideo = v;
                          // });
                          
                          Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPreview(video: v.path)));
                          timersList[carouselIndex2].restart();
                          timersList[carouselIndex2].pause();
                        });
                        setState(() {
                          isLoading = false;
                          hasFullRecord = false;
                          hasRecordedVideo = false;
                          //isRecording = false;
                        });
                        
                        
                      },
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.redAccent
                        ),
                        child: const Center(
                          child: Icon(CupertinoIcons.checkmark_alt, color: Colors.white,),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                  child: AnimatedOpacity(
                duration: const Duration(milliseconds: 100),
                opacity: isRecording || hasRecordedVideo ? 0 : 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 30,
                      child: CarouselSlider.builder(
                          itemCount: 3,
                          itemBuilder: (context, index, realIndex) {
                            return Text(
                              pages[index],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            );
                          },
                          options: CarouselOptions(
                            height: 20,
                            enlargeCenterPage: false,
                            viewportFraction: 0.25,
                            enableInfiniteScroll: false,
                            onPageChanged: (index, reason) {
                              print(pages[index]);
                              setState(() {
                                carouselIndex1 = index;
                              });
                            },
                          )),
                    ),
                    Container(
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                    )
                  ],
                ),
              )),
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 100),
            opacity: !isRecording ? 1 : 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 15),
              child: SafeArea(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      CupertinoIcons.xmark,
                      color: Colors.white,
                      shadows: [Shadow(color: Colors.black, blurRadius: 5)],
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 100),
            opacity: !isRecording ? 1 : 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 15),
              child: SafeArea(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              setState(() {
                                currCameraIdx = currCameraIdx == 0 ? 1 : 0;
                              });
                              _controller = CameraController(
                                  widget.cameras[currCameraIdx],
                                  ResolutionPreset.max);
                              await _controller.initialize().then((value) {
                                if (!mounted) {
                                  return;
                                }
                                setState(() {});
                              });
                            },
                            child: const Icon(
                              CupertinoIcons.arrow_2_circlepath,
                              color: Colors.white,
                              shadows: [
                                Shadow(color: Colors.black, blurRadius: 5)
                              ],
                            ),
                          ),
                          const Text(
                            'Повернуть',
                            style: TextStyle(
                                color: Colors.white,
                                shadows: [
                                  Shadow(color: Colors.black, blurRadius: 5)
                                ],
                                fontSize: 10),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              CupertinoIcons.bolt_slash_fill,
                              color: Colors.white,
                              shadows: [
                                Shadow(color: Colors.black, blurRadius: 5)
                              ],
                            ),
                          ),
                          const Text(
                            'Вспышка',
                            style: TextStyle(
                                color: Colors.white,
                                shadows: [
                                  Shadow(color: Colors.black, blurRadius: 5)
                                ],
                                fontSize: 10),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 50,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                CupertinoIcons.arrow_down_right_arrow_up_left,
                                color: Colors.white,
                                shadows: [
                                  Shadow(color: Colors.black, blurRadius: 5)
                                ],
                              ),
                            ),
                            const Text(
                              'Соотношение сто...',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(color: Colors.black, blurRadius: 5)
                                  ],
                                  fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 50,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                CupertinoIcons.wand_rays_inverse,
                                color: Colors.white,
                                shadows: [
                                  Shadow(color: Colors.black, blurRadius: 5)
                                ],
                              ),
                            ),
                            const Text(
                              'Ретушь',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(color: Colors.black, blurRadius: 5)
                                  ],
                                  fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 100),
            opacity: !isRecording ? 1 : 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 80),
              child: SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 110,
                    height: kToolbarHeight / 2,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(4)),
                    child: const Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            CupertinoIcons.music_note_2,
                            color: Colors.white,
                            size: 15,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Добавить муз...",
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (isLoading)
            Center(
              child: const LoadingCircleAnimation(),
            )
        ],
      ),
    );
  }
}
