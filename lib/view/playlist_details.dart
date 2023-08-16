// playlist details screen
import 'dart:developer';
import 'dart:io';

import 'package:egy_us_tv_admin/model/video_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:video_player_control_panel/video_player_control_panel.dart';

import '../config/color.dart';
import '../widgets/alert.dart';
import 'selected_video.dart';

class DetailsPlaylist extends StatefulWidget {
  final String? title;
  final videos;
  const DetailsPlaylist({super.key, this.title, this.videos});

  @override
  State<DetailsPlaylist> createState() => _DetailsPlaylistState();
}

class _DetailsPlaylistState extends State<DetailsPlaylist> {
  File? videopath;
  getvideo(context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickVideo(source: ImageSource.gallery);
    debugger();
    if (image != null) {
      videopath = File(image.path);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SelectedVideo(path: videopath)));
      setState(() {});
    }
  }

  List images = [
    "https://www.otto.de/updated/app/uploads/2019/06/instagram_stories_und_beitraege_reposten-152x232.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8BU4ikqZSkOTe9n66Au-APycQ-jkWZ_fN6Q&usqp=CAU",
    "https://embedsocial.com/wp-content/uploads/2022/08/social-media-marketing-campaigns-380x360.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVizbW8JO1a8kEwNDGUo4MzMabdA3LQONy7bRkdNvohgdcgg1saqK_KQF0ShEcqyw5Rto&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScETz1S6DFb1HWOt4XQZYjyc8xxIFQKmWMJWLCXaZPq0rNx3c7tvFIU16lAB7wJ3OxLEo&usqp=CAU",
  ];
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: ColorConstants.black),
                ),
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
            widget.title!,
            style: TextStyle(
                color: ColorConstants.black, fontWeight: FontWeight.w500),
          ),
        ),
        body: Stack(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            "assets/main_logo.png"),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${widget.title}",
                            style: TextStyle(
                                color: ColorConstants.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children:  [
                              Icon(
                                Icons.video_collection,
                                size: 20,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("${widget.videos.length} Videos")
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: widget.videos!.length,
                        itemBuilder: (context, index) {
                          VideoModel videoModel = VideoModel.fromJson(widget.videos[index]);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 120,
                              decoration:
                                  BoxDecoration(color: Color(0xffF1F1F1)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 110,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image:
                                                  NetworkImage(images[index]),
                                              fit: BoxFit.cover),
                                        ),

                                        // child: JkVideoControlPanel(
                                        //     socketProvider.controller!,
                                        //     showClosedCaptionButton: false,
                                        //     showFullscreenButton: false,
                                        //     showVolumeButton: false,
                                        //   ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${videoModel.name}",
                                            style: TextStyle(
                                                color: ColorConstants.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text("${videoModel.createdAt}"),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          // Text("05:02 min")
                                        ],
                                      ),
                                    ],
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Row(
                                              children: const [
                                                Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                // Icon(
                                                //   Icons.delete,
                                                //   color: Colors.white,
                                                //   size: 20,
                                                // )
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Row(
                                              children: const [
                                                Icon(
                                                  Icons.play_arrow,
                                                  color: Colors.white,
                                                  size: 20,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )

                                  // Icon(Icons.play_arrow),
                                  // const Icon(
                                  //   Icons.delete,
                                  // )
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0, right: 20),
              child: Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () {
                    getvideo(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Add Video ",
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        )

        //  GridView(
        //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: 2,
        //       childAspectRatio: 1 / 1.2,
        //     ),
        //     // controller: _scrollController,
        //     physics: BouncingScrollPhysics(),
        //     padding: EdgeInsets.only(left: 10, bottom: 20),
        //     children: [
        //       for (int i = 0; i < images.length; i++) ...[
        //         InkWell(
        //           // onLongPress: () {
        //           //   showDialog(
        //           //     context: context,
        //           //     builder: (context) {
        //           //       return Alert(
        //           //         text1:
        //           //             'Are you sure you want to remove video from playlist?',
        //           //         textbutton1: 'Yes',
        //           //         buttoncolor: ColorConstants.red,
        //           //         buttoncolor2: ColorConstants.black,
        //           //         onPressed: () {
        //           //           // logout(context: context).then((value) {
        //           //           //   selectedItemPosition = 0;

        //           //           //   removeKey("token");
        //           //           //   Navigator.of(context).pushNamedAndRemoveUntil(
        //           //           //       AppRoutes.login,
        //           //           //       (Route<dynamic> route) => false);
        //           //           // });
        //           //         },
        //           //       );
        //           //     },
        //           //   );
        //           // },
        //           child: Stack(
        //             children: [
        //               Container(
        //                 width: double.infinity,
        //                 height: double.infinity,
        //                 decoration: BoxDecoration(
        //                   borderRadius: BorderRadius.all(Radius.circular(12)),
        //                   color: ColorConstants.black,
        //                 ),
        //                 margin: EdgeInsets.only(top: 10, right: 10),
        //                 child: ClipRRect(
        //                   borderRadius: BorderRadius.all(Radius.circular(12)),
        //                   child: Container(
        //                     // color: ,
        //                     child: Image(
        //                       image: NetworkImage(images[i]),
        //                       fit: BoxFit.cover,
        //                       errorBuilder: (context, error, stackTrace) {
        //                         return Container();
        //                       },
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //               ClipRRect(
        //                 borderRadius: BorderRadius.all(Radius.circular(12)),
        //                 child: Container(
        //                   margin: EdgeInsets.only(top: 10, right: 10),
        //                   decoration: const BoxDecoration(
        //                     borderRadius: BorderRadius.all(Radius.circular(12)),
        //                     color: Colors.black12,
        //                   ),
        //                   width: double.infinity,
        //                   height: double.infinity,
        //                 ),
        //               ),
        //               Positioned(
        //                   bottom: 20,
        //                   child: Icon(
        //                     Icons.play_arrow,
        //                     size: 35,
        //                     color: ColorConstants.white,
        //                   ))
        //             ],
        //           ),
        //         ),
        //       ],
        //     ]));

        );
  }
}
