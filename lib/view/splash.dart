import 'dart:async';
import 'package:egy_us_tv_admin/utils/preferences.dart';
import 'package:egy_us_tv_admin/utils/utils.dart';
import 'package:egy_us_tv_admin/view/auth/login.dart';
import 'package:egy_us_tv_admin/view/home.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import '../config/images.dart';
import '../socket/connection.dart';
import 'bottombar.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  startTimer() async {
    var _duration = Duration(seconds: 5);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    var token = await Preference.getToken();
    if (token != null) {
      pushUntil(context, Home());
    } else {
      pushUntil(context, EmailLogin());
    }
  }

  @override
  void initState() {
    startTimer();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Image.asset(
            AppImages.splash,
            height: MediaQuery.of(context).size.height * .25,
            width: MediaQuery.of(context).size.width * .85,
          ),
        ),
      ),
    );
  }
}
