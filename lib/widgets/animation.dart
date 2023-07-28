import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget novideo(context) {
  return Center(
    child: Lottie.asset(
      "assets/novideo.json",
      repeat: true,
      reverse: true,
      width: MediaQuery.of(context).size.height * 7,
      height: MediaQuery.of(context).size.height * .6,
    ),
  );
}
