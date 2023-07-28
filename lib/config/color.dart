import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorConstants {
  static Color colorTextLight = Color(0xFF666D7E);
  static Color white = Colors.white;
  static Color black = Colors.black;
  static Color primaryColor = hexToColor('#08632d');
  static Color secondary = hexToColor('#ad1f2d');
  static Color red = hexToColor('#ad1f2d');
  static Color close = hexToColor('#A29FBE');
  static Color star = hexToColor('#4DD5FF');
  static Color favorite = hexToColor('#FF636B');
  static Color active = hexToColor('#08632d');

  static Color grey = hexToColor('#d0d9d7');
  static Color brightOrange = hexToColor('#FF6F59');

  static Color lightBlue = hexToColor('#E5F7FF');
  static Color brightBlue = hexToColor('#33C0FF');

  static Color lightOrange1 = hexToColor('#FFF2E5');
  static Color brightOrange1 = hexToColor('#FF9933');

  static Color lightPurple = hexToColor('#E5ECFF');
  static Color brightPurple = hexToColor('#5985FF');

  static Color lightPurple1 = hexToColor('#F2E5FF');
  static Color brightPurple1 = hexToColor('#9933FF');

  static Color lightGreen = hexToColor('#72ba8a');
  static Color brightGreen = hexToColor('#12B2B2');

  static Color lightPink = hexToColor('#FFE5EE');
  static Color brightPink = hexToColor('#FF3377');
}

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex));

  return Color(int.parse(hex.substring(1), radix: 16) +
      (hex.length == 7 ? 0xFF000000 : 0x00000000));
}
