import 'dart:developer';

import 'package:egy_us_tv_admin/controller/service/api_manager.dart';
import 'package:flutter/material.dart';

import '../../model/get_playlist_model.dart';

class PlaylistProvider extends ChangeNotifier {
  bool isLoading = false;


  GetPlaylistModel? playlist;

  getPlaylist(context) async {
    isLoading = true;
    notifyListeners();
    playlist = await ApiManager.getPlaylist(context);
    print(playlist);
    isLoading = false;
    notifyListeners();
  }



  addPlaylist(context,name)async{
    isLoading = true;
    notifyListeners();
    // debugger();
    // playlist = null;
    await ApiManager.addPlaylist(context, name);
    playlist = await ApiManager.getPlaylist(context);
    // pop(context);
    isLoading = false;
    notifyListeners();
  }



  deletePlaylist(context,id)async{
    isLoading = true;
    notifyListeners();
    await ApiManager.deletePlaylist(context, id);
    await getPlaylist(context);
    isLoading = false;
    notifyListeners();
  }

   runPlaylist(context,id)async{
    isLoading = true;
    notifyListeners();
    var message = await ApiManager.runPlaylist(context, id);
    await getPlaylist(context);
    isLoading = false;
    notifyListeners();

    if(message != null){
    return message;
    }
  }
}
