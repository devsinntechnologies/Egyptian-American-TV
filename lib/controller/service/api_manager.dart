import 'dart:convert';
import 'dart:developer';

import 'package:egy_us_tv_admin/controller/service/endpoint.dart';
import 'package:egy_us_tv_admin/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ApiManager {


  static login(BuildContext context,{ email, password}) async {
    try {
      var url = Uri.parse(BASE_URL + loginEndPoint);
      var response =
          await http.post(url, body: {"email": email, "password": password});
      
      var res = jsonDecode(response.body);
     showSnackBar(context, res["message"]);
      // debugger();

      return res;
    } catch (e) {
      print(e);
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
