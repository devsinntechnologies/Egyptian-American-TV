import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:nb_utils/nb_utils.dart';
import '../config/app_constant.dart';


class ApiClient {
  static final Dio _dio = Dio();
  static Future<dynamic> postApitCall(
      {required String url, required Map<String, dynamic> mapData}) async {
    try {
      FormData formData = FormData.fromMap(mapData);
      Response response = await _dio.post(
        AppConstant.apiPath + url,
        data: formData,
        options: Options(
          headers: {
            // "Content-Type": "application/json",
            "Authorization": "Bearer ${getStringAsync("token")}",
            // "Token": "${getStringAsync("token")}",
          },
        ),
      );
      return response.data;
    } on DioError catch (e) {
      if (e.error is SocketException) {
        if (kDebugMode) {
          print('SocketException: ${e.error}');
        }
        return AppConstant.socketException;
      } else {
        if (kDebugMode) {
          print('DioEr ror: ${e.message}');
        }
        return e.response?.data;
      }
    }
  }

  static Future<dynamic> getApitCall(
      {required String url, Map<String, dynamic>? mapData}) async {
    try {
      Response response = await _dio.get(AppConstant.apiPath + url,
          queryParameters: mapData ?? {},
           options: Options(
          headers: {
            
            "Authorization": "Bearer ${getStringAsync("token")}",
          
          },
          ));
      return response.data;
    } on DioError catch (e) {
      return e.response?.data;
    }
  }
}
