import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PublishVideo extends StatefulWidget {
  const PublishVideo({super.key});

  @override
  State<PublishVideo> createState() => _PublishVideoState();
}

class _PublishVideoState extends State<PublishVideo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Опубликовать",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17
          ),
        ),
      ),
      body: Column(
        children: [
          
        ],
      )
    );
  }
}