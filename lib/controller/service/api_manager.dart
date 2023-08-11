import 'dart:convert';
import 'dart:developer';

import 'package:egy_us_tv_admin/controller/service/endpoint.dart';
import 'package:egy_us_tv_admin/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

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

      // showSnackBar(context, res["message"]);

      return res;
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
