import 'package:egyptian_american_tv/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customAlert(
    {title, content, primaryColor, secondaryColor, deleteBtn, cancelBtn}) {
  return AlertDialog(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.warning,
          color: primaryColor,
        ),
        Text(title),
      ],
    ),
    content: content,
    actions: [
      TextButton(
        onPressed: deleteBtn,
        child: Text('Ok',
            style: TextStyle(
              color: Colors.white,
            )),
        style: ButtonStyle(
          backgroundColor: primaryColor,
        ),
      ),
      TextButton(
        onPressed: cancelBtn,
        child: Text(
          'Cancel',
          style: TextStyle(color: Colors.black),
        ),
        style: ButtonStyle(
          backgroundColor: secondaryColor,
        ),
      ),
    ],
  );
}
