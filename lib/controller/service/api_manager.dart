import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:egy_us_tv_admin/controller/service/endpoint.dart';
import 'package:egy_us_tv_admin/model/get_playlist_model.dart';
import 'package:egy_us_tv_admin/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ApiManager {
  static login(BuildContext context, {email, password}) async {
    try {
      var url = Uri.parse(BASE_URL + loginEndPoint);
      var response =
          await http.post(url, body: {"email": email, "password": password});

      var res = jsonDecode(response.body);
      showSnackBar(context, res["message"]);

      return res;
    } catch (e) {
      print(e);
      showSnackBar(context, e.toString());
    }
  }

  /// Get Play List API
  static getPlaylist(context) async {
    try {
      var url = Uri.parse(BASE_URL + getPlaylistEndpoint);
      var response = await http.get(url);

      var res = jsonDecode(response.body);

      var dat = GetPlaylistModel.fromJson(res);

      print(dat);
      return dat;
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
  
  /// RUN Playlist
  static runPlaylist(context,id) async {
    try {
      var url = Uri.parse( onlyBase +":" + socketPort + "/"+ runPlaylistEndpoint + id);
      var response = await http.get(url);
// debugger();
      var res = jsonDecode(response.body);

      // var dat = GetPlaylistModel.fromJson(res);

      // print(dat);
      return res["message"];
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  ///  Add New PlayList

  static addPlaylist(context, name) async {
    try {
      var url = Uri.parse(BASE_URL + addPlaylistEndpoint);
      var response = await http.post(url, body: {"name": name});

      var res = jsonDecode(response.body);
      showSnackBar(context, res["message"]);
      return res;
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  ///////// Delete Video
  ///

  static deletePlaylistVideo(context, videoID, playlistID) async {
    try {
      final queryParameters = {
        'videoId': '$videoID',
        'playlistId': '$playlistID',
      };
      var url =
          Uri.http(base, "/api/"+deletePlaylistVideoEndpoint, queryParameters);
      var response = await http.delete(url);
// debugger();
      var res = jsonDecode(response.body);
      showSnackBar(context, res["message"]);
      return res;
    } catch (e) {
      // debugger();

      showSnackBar(context, e.toString());
    }
  }

  ///  Delete PlayList

  static deletePlaylist(context, id) async {
    try {
      var url = Uri.parse(BASE_URL + deletePlaylistEndpoint + id);
      var response = await http.delete(url);

      var res = jsonDecode(response.body);
      showSnackBar(context, res["message"]);
      return res;
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  static uploadVideo(context, video, playlistID, order) async {
    debugger();
    var data = FormData.fromMap({
      'files': [await MultipartFile.fromFile(video, filename: video)],
      'playlistId': 'c050917396e9a43998e22f4d0650b1a0',
      'order': '2'
    });

    var dio = Dio();
    try {
      debugger();

      var response = await dio.request(
        'http://3.80.91.77:3000/api/video/upload',
        options: Options(
          method: 'POST',
        ),
        data: data,
      );
      debugger();
      if (response.statusCode == 200) {
        print(json.encode(response.data));
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      debugger();
      print('Error: $e');
    }

//   var request = http.MultipartRequest('POST', Uri.parse(BASE_URL+ uploadVideoEndpoint ));
// request.fields.addAll({
//   'playlistId': playlistID,
//   'order': order
// });
// try {
// request.files.add(await http.MultipartFile.fromPath('video', video));
// debugger();
// var response = await request.send().timeout(const Duration(seconds: 50));
// d[ebugger();
// if (response.statusCode == 200) {
//   print(await response.stream.bytesToString());
// }
// else {
//   print(response.reasonPhrase);
// }

// } catch (e) {
//   debugger();
//   print(e);
// }
  }
}

// "1124" + "9999" = "11249999"

// 1 + 1 = 2

// API

// 1- Endpoint (BASE + Endpoint) (Require)
// 2- Method  (Require)
// GET
// POST
// PUT
// PATCH
// DELETE
// 3- BODY OR PARAMS (Optional)
// 4- HEADERS (Optional)
