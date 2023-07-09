import 'dart:developer';
import 'dart:io';
import 'dart:math';
import 'package:egypt_american/utils/constant.dart';
import 'package:egypt_american/utils/custom_video_player.dart';
import 'package:egypt_american/utils/customTile.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AddVideoScreen extends StatefulWidget {
  var playListName;
  AddVideoScreen({required this.playListName});
  @override
  State<AddVideoScreen> createState() => _AddVideoScreenState();
}

class _AddVideoScreenState extends State<AddVideoScreen> {
  _pickVideo() async {
    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: true,
    );

    for (var item in pickedFile!.files) {
      var controller;
      controller = VideoPlayerController.file(File(item.path!))
        ..initialize().then((_) {
          controller.pause();
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          video.add({
            "size": item.size,
            "name": item.name,
            "path": item.path,
            "controller": controller
          });

          setState(() {});
        });
    }

    // debugger();

    // if (pickedFile != null) {
    //   String videoPath = pickedFile.files.single.path!;

    //   setState(() {
    //     _video = File(videoPath);
    //     // _video.
    //   });
    // }
  }

  List video = [];

  @override
  Widget build(BuildContext context) {
    // print(video);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.playListName}",
        ),
        actions: [
          MaterialButton(
            onPressed: () {},
            child: Text("Upload"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await _pickVideo();

          setState(() {});
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < video.length; i++)
              customTile(
                title: '${video[i]["name"]}',
                subtitle: '${((video[i]["size"] / 1024) / 1024).round()} MB',
                icon: Icons.delete,
                iconTap: () {
                  setState(() {
                    video.removeAt(i);
                  });
                },
                tileTap: () {
                  video[i]["controller"].play();
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (_) => CustomVideoPlayer(
                        title: video[i]["name"],
                        controller: video[i]["controller"],
                      ),
                    ),
                  );
                },
                child: VideoPlayer(
                  video[i]["controller"],
                ),
                iconColor: kWarningColor,
              ),
          ],
        ),
      ),
    );
  }
}

// 