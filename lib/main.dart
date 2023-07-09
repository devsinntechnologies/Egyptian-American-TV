import 'package:egypt_american/utils/constant.dart';
import 'package:egypt_american/view/addPlayList.dart';
import 'package:flutter/material.dart';

import 'view/addVideoScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green,
        // secondaryHeaderColor: kPrimaryColor,
      ),
      home: AddPlayListScreen(),
    );
  }
}
