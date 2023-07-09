import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  var title, controller;
  CustomVideoPlayer({
    required this.title,
    required this.controller,
  });

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: widget.controller,
      aspectRatio: 16 / 9, // Replace with your desired aspect ratio
      autoPlay: false,
      looping: true,
      // Additional configurations can be added here
    );
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController.dispose();
    widget.controller.pause();
  }

// final playerWidget= Chewie(controller: widget.controller);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Chewie(
        controller: _chewieController,
      ),
    );
  }
}
