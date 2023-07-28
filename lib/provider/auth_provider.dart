import 'dart:convert';
import 'package:egy_us_tv_admin/view/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../config/app_constant.dart';
import '../services/api_services.dart';
import '../widgets/custom_loader.dart';


class AuthController extends ChangeNotifier {
  bool loading = false;
  bool internet = false;

// Login api////////////////////////////////////////////////////

  Future<void> loginAppUser({required mapData, required context}) async {
    loading = false;
    internet = false;
    customLoader(context: context);
    dynamic res = await ApiClient.postApitCall(url: "login", mapData: mapData);
    log("auth response is $res");
    if (res == AppConstant.socketException) {
      Navigator.pop(context);
      loading = false;
      internet = true;
      notifyListeners();
      toast("No internet");
    } else if (res["api_status"] == 400) {
      Navigator.pop(context);
      loading = false;
      internet = false;
      notifyListeners();
      toast("$res[message]");
    } else if (res["api_status"] == 500) {
      Navigator.pop(context);
      loading = false;
      internet = false;
      notifyListeners();
      toast("$res[message]");
    } else if (res["status"] == 200) {
      Navigator.pop(context);
      log(res["message"]);
      await setValue("token", res["data"]["token"]);
      toast("Login successfully");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Home()),
          (route) => false);
    }
    loading = false;
    notifyListeners();
  }
}
