import 'package:flutter/material.dart';

import '../config/color.dart';

Future customLoader({required context}){
  return showDialog(context:context , builder: (context) {
    return  Center(
      child:  CircularProgressIndicator(
        color: ColorConstants.primaryColor,
      ),
    );
  },);
}