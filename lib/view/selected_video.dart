import 'dart:io';

import 'package:egy_us_tv_admin/config/color.dart';
import 'package:egy_us_tv_admin/controller/service/api_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class SelectedVideo extends StatefulWidget {
  File? path;
  final playlistID,order;
  SelectedVideo({this.path,this.order,this.playlistID});

  @override
  _SelectedVideoState createState() => _SelectedVideoState();
}

class _SelectedVideoState extends State<SelectedVideo> {
  VideoPlayerController? controller;
  bool _isFullScreen = false;
  bool _isVideoInitializing = true; // New flag to track video initialization

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.file(widget.path!)
      ..initialize().then((_) {
        setState(() {
          _isVideoInitializing = false; // Video is initialized
        });
      });
    controller!.play();
    controller!.setLooping(true);
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
        backgroundColor: ColorConstants.active,
        elevation: 0,
        // automaticallyImplyLeading: false,
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(10.0),
        //     child: InkWell(
        //       onTap: (){

        //         ApiManager.uploadVideo(context, widget.path!.path, widget.playlistID, widget.order);
                 
        //       },
        //       child: Container(
        //        decoration: BoxDecoration(
        //                           color: ColorConstants.primaryColor,
        //                           borderRadius: BorderRadius.all(Radius.circular(5)),
        //                           border:
        //                               Border.all(color: ColorConstants.primaryColor)),
                              
        //         child: Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: Text(
        //             "Send",
        //             style: TextStyle(
        //                 color: ColorConstants.white,
        //                 fontSize: 16,
        //                 fontWeight: FontWeight.bold),
        //           ),
        //         ),
        //       ),
        //     ),
        //   )
        // ],
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
