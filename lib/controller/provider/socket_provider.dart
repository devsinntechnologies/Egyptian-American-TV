import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:video_player/video_player.dart';

import '/model/linkModel.dart';

class SocketProvider extends ChangeNotifier {
  LinksModel? urls;
  late IO.Socket _socket;

  VideoPlayerController? controller;

  VideoPlayerController? nextController;

  String socketUrl = "http://3.80.91.77";
  String socketPort = "5000";
  String socketVideoPath = "/videos/";

  connection() {
    debugger();
    IO.Socket socket = IO.io(socketUrl + ":" + socketPort,
     <String, dynamic>{
      'transports': ['websocket'],
      'upgrade': false
    });
    socket.onConnect((_) {
      print('connect');
    });
      socket.connect();
    socket.on("connect", (data) {
      print("Connection Successfully Established...");
      // onSocketConnected(socketIO);
    });
    
    socket.on('video_links', (data) {
      print(data);
      if (data != null) {
        LinksModel urlData = LinksModel.fromJson(data);
        if (urls == null ||
            (urlData.currentVideoLink != urls!.currentVideoLink &&
                urlData.nextVideoLink != urls!.nextVideoLink)) {
          print(data);
          urls = urlData;
          playVideo(urls);
          print(urls!.currentVideoLink);
          notifyListeners();
        }
      }
    });
    socket.onDisconnect((_) => print('disconnect'));
  }

  void playVideo(LinksModel? url) {
    controller = VideoPlayerController.network(
        socketUrl + socketVideoPath + url!.currentVideoLink!,
         videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
        );
    controller!.initialize().then((value) {
      if (!controller!.value.isInitialized) {
        log("controller.initialize() failed");
        return;
      }
      controller!.play();
    }).catchError((e) {
      log("controller.initialize() error occurs: $e");
    });

    // nextController = VideoPlayerController.network(
    //     socketUrl + socketVideoPath + url.nextVideoLink!);
    // nextController!.initialize().then((value) {
    //   if (!nextController!.value.isInitialized) {
    //     log("controller.initialize() failed");
    //     return;
    //   }
    //   // controller!.play();
    // }).catchError((e) {
    //   log("controller.initialize() error occurs: $e");
    // });
  }
}
