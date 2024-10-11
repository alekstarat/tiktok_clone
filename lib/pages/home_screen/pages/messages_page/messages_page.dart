import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tiktok_clone/components/loading_circle_animation.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {

  late final WebSocket socket;

  void initSocketServer() async {
    socket = await WebSocket.connect('ws://10.0.2.2:8000/ws');

    socket.listen(
      (message) => print("Recieved message: $message"),
      onError: (message) => print("Recieved error: $message")
    );

    socket.add("");
  }

  void closeSocketServer() async {
    await socket.close();
  }

  @override
  void initState() {
    super.initState();
    initSocketServer();
  }

  @override
  void dispose() {
    closeSocketServer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container()
    );
  }
}