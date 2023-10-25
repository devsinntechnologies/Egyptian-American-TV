import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:video_player/video_player.dart';

import '/model/linkModel.dart';

  String socketUrl = "http://3.80.91.77";
  String socketPort = "5000";
  String socketVideoPath = "/videos/";
class SocketProvider extends ChangeNotifier {
  LinksModel? urls;
  late IO.Socket _socket;

  VideoPlayerController? controller;

  VideoPlayerController? nextController;

  bool isSocketRunning = false;


  connection() {
    // debugger();
    IO.Socket socket = IO.io(socketUrl + ":" + socketPort,
     <String, dynamic>{
      'transports': ['websocket'],
      'upgrade': false
    });
    socket.onConnect((_) {
      
      isSocketRunning = true;
      notifyListeners();
      print('connect');
    });
      socket.connect();
      isSocketRunning = true;
      notifyListeners();
    socket.on("connect", (data) {
      print("Connection Successfully Established...");
    });
    
    socket.on('video_links', (data) {
      print(data);
      // debugger();
      if (data != null) {
        LinksModel urlData = LinksModel.fromJson(data);
        if (urls == null ||
            (urlData.currentVideoLink != urls!.currentVideoLink &&
                urlData.nextVideoLink != urls!.nextVideoLink)) {
          print(data);
          urls = urlData;
          
      isSocketRunning = true;
      notifyListeners();
          playVideo(urls);
          print(urls!.currentVideoLink);
          notifyListeners();
        }
      }
    });
    socket.onDisconnect((_){
      print("Disconnect");
      isSocketRunning = false;
      notifyListeners();
    });
  }

  void playVideo(LinksModel? url) {
    String singleURL = socketUrl + socketVideoPath + url!.currentVideoLink!;
    controller = VideoPlayerController.network(
        singleURL,
         videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
        );
        print(singleURL + "---------------------- my URL");
    controller!.initialize().then((value) {
      if (!controller!.value.isInitialized) {
        log("controller.initialize() failed");
        return;
      }
      // debugger();
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
