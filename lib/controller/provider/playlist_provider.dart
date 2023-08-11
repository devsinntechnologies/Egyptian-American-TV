import 'dart:developer';

import 'package:egy_us_tv_admin/controller/service/api_manager.dart';
import 'package:flutter/material.dart';

class PlaylistProvider extends ChangeNotifier {
  bool isLoading = false;


  var playlist;

  getPlaylist(context) async {
    isLoading = true;
    notifyListeners();
    playlist = await ApiManager.getPlaylist(context);
    isLoading = false;
    notifyListeners();
  }



  addPlaylist(context,name)async{
    isLoading = true;
    notifyListeners();
    // playlist = null;
    await ApiManager.addPlaylist(context, name);
    playlist = await ApiManager.getPlaylist(context);
    isLoading = false;
    notifyListeners();
  }



  deletePlaylist(context,id)async{
    isLoading = true;
    // notifyListeners();
    await ApiManager.deletePlaylist(context, id);
    isLoading = false;
    // notifyListeners();
  }
}
