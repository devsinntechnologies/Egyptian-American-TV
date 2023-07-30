import 'package:nb_utils/nb_utils.dart';

class Preference {
  static String tokenKey = "token";

  static saveToken(token) async {
    try {
      var pref = await SharedPreferences.getInstance();
      pref.setString(tokenKey, token);
      return true;
    } catch (e) {
      return false;
    }
  }

  static getToken() async {
    var pref = await SharedPreferences.getInstance();
    var data = pref.getString(tokenKey);
    if (data != null) {
      return data;
    }
  }
}
