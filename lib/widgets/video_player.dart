import 'dart:io';

import 'package:egy_us_tv_admin/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../controller/provider/socket_provider.dart';

class VideoPreviewer extends StatefulWidget {
  String? path;
  VideoPreviewer({this.path});

  @override
  _VideoPreviewerState createState() => _VideoPreviewerState();
}

class _VideoPreviewerState extends State<VideoPreviewer> {
  VideoPlayerController? controller;
  bool _isFullScreen = false;
  bool _isVideoInitializing = true; // New flag to track video initialization

  @override
  void initState() {
    super.initState();
    print(socketUrl + socketVideoPath + widget.path!);
    controller = VideoPlayerController.networkUrl(Uri.parse(socketUrl + socketVideoPath + widget.path!))
      ..initialize().then((_) {
        setState(() {
          _isVideoInitializing = false; // Video is initialized
        });
      });
    controller!.play();
    // controller!.setLooping(true);
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
      if (_isFullScreen) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      } else {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Center(
            child: _isVideoInitializing
                ? CircularProgressIndicator() // Display loader while video is initializing
                : Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: controller!.value.aspectRatio,
                        child: VideoPlayer(controller!),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 0,
                        child: IconButton(
                          icon: Icon(
                            _isFullScreen
                                ? Icons.fullscreen_exit
                                : Icons.fullscreen,
                            color: Colors.white,
                          ),
                          onPressed: _toggleFullScreen,
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
