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
      showSnackBar(context, "Please, Enter Password");
    } else {
      isLoading = true;
      notifyListeners();

      var res =
          await ApiManager.login(context, email: email, password: password);
      if (res["success"] == true || res["StatusCode"] == 200) {
        print("${res["data"]["access_token"]}");
        await Preference.saveToken("${res["data"]["access_token"]}");
        pushUntil(context, Home());
      } else {
        showSnackBar(context, '${res['message']}');
        isLoading = false;
        notifyListeners();
      }
      isLoading = false;
      notifyListeners();
    }
  }

  logout() async {
    await Preference.remveToken();
    notifyListeners();
  }
}
