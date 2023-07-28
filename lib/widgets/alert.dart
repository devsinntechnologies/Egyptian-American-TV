import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Alert extends StatefulWidget {
  String? maintext;
  String? text1;
  String? textbutton1;
  Color? buttoncolor;
  Color? buttoncolor2;
  final VoidCallback? onPressed;
  Alert(
      {super.key,
      this.buttoncolor,
      this.buttoncolor2,
      this.maintext,
      this.onPressed,
      this.text1,
      this.textbutton1});

  @override
  State<Alert> createState() => _AlertState();
}

class _AlertState extends State<Alert> {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Container(
        height: 65,
        width: 65,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/app_logo.png"), fit: BoxFit.contain)),
      ),
      content: Text(widget.text1!),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          isDestructiveAction: true,
          child: Text(
            widget.textbutton1!,
            style: TextStyle(color: widget.buttoncolor!),
          ),
          onPressed: widget.onPressed,
        ),
        CupertinoDialogAction(
          child: Text(
            "Cancel",
            style: TextStyle(color: widget.buttoncolor2!),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
