import 'dart:developer';

import 'package:egy_us_tv_admin/model/linkModel.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketProvider extends ChangeNotifier {

  LinksModel? urls;
  late IO.Socket _socket;

  SocketProvider() {
    debugger();
    _initSocket();
  }
  connection() {
    IO.Socket socket = IO.io('http://192.168.10.11:3000');
    socket.onConnect((_) {
      print('connect');      
    });
    socket.on('video_links', (data){
       LinksModel urlData =  LinksModel.fromJson(data);
        urls = urlData;
        notifyListeners();
    });
    socket.onDisconnect((_) => print('disconnect'));
  }



   void _initSocket() {
    _socket = IO.io('http://192.168.10.11:3000');

      debugger();
    _socket.onConnect((_) {
      print('connect');
    });

    _socket.on('video_links', (data) {
      print(data);
      // _videoLinks = data;
      notifyListeners(); // Notify listeners when data is updated
    });

    _socket.onDisconnect((_) {
      print('disconnect');
    });
  }

  // void disposeSocket() {
  //   _socket.dispose();
  // }
}
