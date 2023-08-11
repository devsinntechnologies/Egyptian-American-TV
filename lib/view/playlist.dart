import 'dart:io';

import 'package:egy_us_tv_admin/controller/provider/playlist_provider.dart';
import 'package:egy_us_tv_admin/utils/utils.dart';
import 'package:egy_us_tv_admin/view/create_playlist.dart';
import 'package:egy_us_tv_admin/view/playlist_details.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../config/color.dart';
import '../widgets/alert.dart';
import '../widgets/custom_textfield.dart';
import 'bottombar.dart';

class Playlist extends StatefulWidget {
  const Playlist({super.key});

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
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
  void initState() {
    getPlaylist();
    super.initState();
  }

  getPlaylist() {
    var provider = context.read<PlaylistProvider>();
    provider.getPlaylist(context);
  }

      final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
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
        title: Text(
          "Playlists",
          style: TextStyle(
              color: ColorConstants.black, fontWeight: FontWeight.w500),
        ),
      ),
      body: Builder(builder: (context) {
        var provider = context.watch<PlaylistProvider>();
    
        return provider.isLoading
            ? Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : SingleChildScrollView(
              child: RefreshIndicator(
                  onRefresh: (){
                        return context.read<PlaylistProvider>().getPlaylist(context);

              },
                child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Container(
                              color: ColorConstants.grey,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: const Center(
                                        child: Text(
                                          "Image",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 200,
                                      // color: Colors.black,
                                      child: const Center(
                                        child: Text(
                                          "Title",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      child: const Center(
                                        child: Text(
                                          "VideoCount",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      child: const Center(
                                        child: Text(
                                          "Delete",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      child: const Center(
                                        child: Text(
                                          "Play",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            for (int i = 0;
                                i < provider.playlist["data"].length;
                                i++) ...[
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const DetailsPlaylist(
                                                  title: "Playlist",
                                                )));
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        border: Border(
                                            bottom:
                                                BorderSide(color: Colors.black26))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 100,
                                            child: Center(
                                              child: Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(12),
                                                      image: const DecorationImage(
                                                          image: NetworkImage(
                                                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHXxIYiq_T7DYdZfqlUfa9Lg3P2cM6xiR7177e-UtoOhKZejmht22JGGrcvfm1TM02V3U&usqp=CAU"),
                                                          fit: BoxFit.fitHeight))),
                                            ),
                                          ),
                                          Container(
                                            width: 200,
                                            child: Center(
                                              child: Text(
                                                provider.playlist["data"][i]
                                                    ["name"],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 100,
                                            child: const Center(
                                              child: Text(
                                                "15",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                              width: 100,
                                              child: Center(
                                                child: InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return Alert(
                                                          maintext: "Paytrust",
                                                          text1:
                                                              'Are you sure you want to remove playlist?',
                                                          textbutton1: 'Yes',
                                                          buttoncolor:
                                                              ColorConstants.red,
                                                          buttoncolor2:
                                                              ColorConstants.black,
                                                          onPressed: () {
                                                            Navigator.pop(context);
                                                            provider.deletePlaylist(context,provider.playlist["data"][i]["id"] );
                                                          },
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: ColorConstants.red,
                                                  ),
                                                ),
                                              )),
                                          Container(
                                              width: 100,
                                              child: Center(
                                                child: Icon(
                                                  Icons.play_arrow,
                                                  color: ColorConstants.lightGreen,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                          
                                // GestureDetector(
                                //   onTap: () {
                                //     Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //             builder: (context) => const DetailsPlaylist(
                                //                   title: "Playlist",
                                //                 )));
                                //   },
                                //   onLongPress: () {
                                //     showDialog(
                                //       context: context,
                                //       builder: (context) {
                                //         return Alert(
                                //           maintext: "Paytrust",
                                //           text1: 'Are you sure you want to remove playlist?',
                                //           textbutton1: 'Yes',
                                //           buttoncolor: ColorConstants.red,
                                //           buttoncolor2: ColorConstants.black,
                                //           onPressed: () {},
                                //         );
                                //       },
                                //     );
                                //   },
                                //   child: Container(
                                //       decoration: BoxDecoration(
                                //           border: Border.all(color: ColorConstants.white)),
                                //       child: ListTile(
                                //         leading: Container(
                                //             height: 40,
                                //             width: 40,
                                //             decoration: BoxDecoration(
                                //                 borderRadius: BorderRadius.circular(12),
                                //                 image: const DecorationImage(
                                //                     image: NetworkImage(
                                //                         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHXxIYiq_T7DYdZfqlUfa9Lg3P2cM6xiR7177e-UtoOhKZejmht22JGGrcvfm1TM02V3U&usqp=CAU"),
                                //                     fit: BoxFit.fitHeight))),
                                //         subtitle: Marquee(
                                //             direction: Axis.horizontal,
                                //             directionMarguee: DirectionMarguee.oneDirection,
                                //             child: Text(
                                //                 "Lay Down Your Demo Scratch Vocal. ...Embellish. ...Lay Down Your Vocals. ...Put A Mix On It. ...")),
                                //         title: Text(
                                //           "Playlist 1",
                                //           style: TextStyle(
                                //               color: ColorConstants.black, fontSize: 16),
                                //         ),
                                //         trailing: Icon(
                                //           Icons.playlist_play,
                                //           color: ColorConstants.black,
                                //         ),
                                //       )),
                                // ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0, right: 20),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Center(child: Text("Create Playlist")),
                                      content: StatefulBuilder(
                                          builder: (context, setState) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            // Center(
                                            //   child: InkWell(
                                            //     onTap: () async {
                                            //       await _getFromGallery();
                                            //     },
                                            //     child: Stack(
                                            //       // fit: StackFit.passthrough,
                                            //       clipBehavior: Clip.none,
                                            //       children: [
                                            //         imagePath == null
                                            //             ? Container(
                                            //                 height: 150,
                                            //                 width: 150,
                                            //                 decoration: BoxDecoration(
                                            //                     shape:
                                            //                         BoxShape.circle,
                                            //                     border: Border.all(
                                            //                         color: Colors
                                            //                             .black45)),
                                            //                 child: Column(
                                            //                   crossAxisAlignment:
                                            //                       CrossAxisAlignment
                                            //                           .center,
                                            //                   mainAxisAlignment:
                                            //                       MainAxisAlignment
                                            //                           .center,
                                            //                   children: const [
                                            //                     Icon(
                                            //                       Icons.image,
                                            //                       size: 50,
                                            //                       color: Colors
                                            //                           .black54,
                                            //                     ),
                                            //                     SizedBox(
                                            //                       height: 5,
                                            //                     ),
                                            //                     Text(
                                            //                       "Select thumbnail",
                                            //                       style: TextStyle(
                                            //                           color: Colors
                                            //                               .black54,
                                            //                           fontSize: 13),
                                            //                     )
                                            //                   ],
                                            //                 ),
                                            //               )
                                            //             : CircleAvatar(
                                            //                 radius: 75,
                                            //                 backgroundColor: Colors
                                            //                     .green.shade50,
                                            //                 backgroundImage:
                                            //                     FileImage(
                                            //                         imagePath!),
                                            //               ),
                                            //       ],
                                            //     ),
                                            //   ),
                                            // ),
                                            // const SizedBox(
                                            //   height: 20,
                                            // ),
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
                                                  var bloc = context.read<PlaylistProvider>();
                                                  if (title.text.isEmpty) {
                                                    showSnackBar(context, "Please! Enter Name");
                                                  }else{
                          pop(context);
                                                  //  Navigator.pop(context);
                          bloc.addPlaylist(context, title.text);
                          
                                                  }
                          
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .2,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: ColorConstants
                                                              .active)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(12.0),
                                                    child: Center(
                                                      child: Text(
                                                        "Create",
                                                        style: TextStyle(
                                                            color: ColorConstants
                                                                .active),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        );
                                      }),
                                    );
                                  });
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
                                      "Create Playlist",
                                    )
                                  ],
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
      }),
    );
  }
}
