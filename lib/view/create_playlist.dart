// form for create playlist

import 'dart:io';

import 'package:egy_us_tv_admin/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../config/color.dart';

class CreatePlaylist extends StatefulWidget {
  const CreatePlaylist({super.key});

  @override
  State<CreatePlaylist> createState() => _CreatePlaylistState();
}

class _CreatePlaylistState extends State<CreatePlaylist> {
  TextEditingController title = TextEditingController();
  File? imagePath;
  _getFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath = File(image.path);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(14.0),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(8),
              //   border: Border.all(color: ColorConstants.black),
              // ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 4.0),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 15,
                    color: ColorConstants.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Create Playlist",
          style: TextStyle(
              color: ColorConstants.black, fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: InkWell(
                onTap: () async {
                  await _getFromGallery();
                },
                child: Stack(
                  // fit: StackFit.passthrough,
                  clipBehavior: Clip.none,
                  children: [
                    imagePath == null
                        ? Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.black45)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.image,
                                  size: 50,
                                  color: Colors.black54,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Select thumbnail",
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 13),
                                )
                              ],
                            ),
                          )
                        : CircleAvatar(
                            radius: 75,
                            backgroundColor: Colors.green.shade50,
                            backgroundImage: FileImage(imagePath!),
                          ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text("Playlist title"),
            const SizedBox(
              height: 10,
            ),
            CustomFormField(
                color: Colors.white,
                hintText: "",
                icon: Icons.edit,
                border: 10,
                controller: title),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  // api hit
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * .4,
                 decoration: BoxDecoration(
                                color: ColorConstants.primaryColor,
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                border:
                                    Border.all(color: ColorConstants.primaryColor)),
                            
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Text(
                        "Create",
                        style: TextStyle(color: ColorConstants.white),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
