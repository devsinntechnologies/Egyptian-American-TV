import 'package:egy_us_tv_admin/controller/service/api_manager.dart';
import 'package:egy_us_tv_admin/utils/preferences.dart';
import 'package:egy_us_tv_admin/utils/utils.dart';
import 'package:egy_us_tv_admin/view/home.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool isLoading = false;


  login(context, {email, password}) async {
    if (email.isEmpty) {
      showSnackBar(context, "Please, Enter Email Address");
    } else if (password.isEmpty) {
      showSnackBar(context,"Please, Enter Password");
    } else {
      isLoading = true;
      notifyListeners();

      var res =
          await ApiManager.login(context, email: email, password: password);

      if (res["data"] != null) {
        await Preference.saveToken(res["data"]["access_token"]);
          pushUntil(context, Home());
      }

      isLoading = false;
      notifyListeners();
    }
  }
}
