
import 'dart:ui';

import 'package:egy_us_tv_admin/agora_setup/agora_preview.dart';
import 'package:egy_us_tv_admin/config/color.dart';
import 'package:egy_us_tv_admin/controller/provider/playlist_provider.dart';
import 'package:egy_us_tv_admin/controller/provider/socket_provider.dart';
import 'package:egy_us_tv_admin/utils/utils.dart';
import 'package:egy_us_tv_admin/view/auth/login.dart';
import 'package:egy_us_tv_admin/view/playlist.dart';
import 'package:egy_us_tv_admin/view/playlist_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import "package:egy_us_tv_admin/utils/utils.dart" as nav;
import '../controller/provider/login_provider.dart';
import '../socket/connection.dart';
import '../widgets/alert.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List images = [
    "https://www.otto.de/updated/app/uploads/2019/06/instagram_stories_und_beitraege_reposten-152x232.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8BU4ikqZSkOTe9n66Au-APycQ-jkWZ_fN6Q&usqp=CAU",
    "https://embedsocial.com/wp-content/uploads/2022/08/social-media-marketing-campaigns-380x360.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVizbW8JO1a8kEwNDGUo4MzMabdA3LQONy7bRkdNvohgdcgg1saqK_KQF0ShEcqyw5Rto&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScETz1S6DFb1HWOt4XQZYjyc8xxIFQKmWMJWLCXaZPq0rNx3c7tvFIU16lAB7wJ3OxLEo&usqp=CAU",
  ];

  @override
  void initState() {
    var provider = context.read<PlaylistProvider>();
    var socketProvider = context.read<SocketProvider>();
       socketProvider.connection();
       
    provider.getPlaylist(context);
    // playPrevVideo("http://50.16.82.20/videos/video3.mp4");
    super.initState();
  }

String getGreeting() {
  final currentTime = DateTime.now();
  final hour = currentTime.hour;  
 if (hour >= 5 && hour < 12) {
    return 'Good Morning';
  } else if (hour >= 12 && hour < 17) {
    return 'Good Afternoon';
  } else if (hour >= 17 && hour < 20) {
    return 'Good Evening';
  } else {
    return 'Good Night';
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body:  SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * .01,
                horizontal: MediaQuery.of(context).size.width * .01,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/main_logo.png",
                                ),
                                fit: BoxFit.contain)),
                      ),
                      Text(
                        "Dashboard",
                        style: TextStyle(
                            color: ColorConstants.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 22),
                      ),
                      IconButton(
                          onPressed: () {
                              var myProvider = context.read<LoginProvider>();
                            myProvider.logout();
                            pushUntil(context, EmailLogin());
                          },
                          icon: Icon(Icons.logout)),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "WELCOME ADMIN!",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: ColorConstants.black),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                getGreeting(),
                                style: TextStyle(
                                    fontSize: 14, color: ColorConstants.active),
                              ),
                              SizedBox(width: 10),

                              Builder(builder: (context){
                                var bloc = context.watch<SocketProvider>();
                                return bloc.isSocketRunning?
                                CircleAvatar(
                                  radius: 7,
                                  backgroundColor: Colors.green

                                )
                                 : CircleAvatar(
                                  radius: 7,
                                  backgroundColor: Colors.red,

                                );
                              })
                            ],
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Alert(
                                text1:
                                    'Are you sure you want to stop Tv Stream and  go Live?',
                                textbutton1: 'Live',
                                buttoncolor: ColorConstants.red,
                                buttoncolor2: ColorConstants.black,
                                onPressed: () {
                                  Navigator.pop(context);

                                  nav.push(context, AgoraMyPreview() );
                                  // logout(context: context).then((value) {
                                  //   selectedItemPosition = 0;

                                  //   removeKey("token");
                                  //   Navigator.of(context).pushNamedAndRemoveUntil(
                                  //       AppRoutes.login,
                                  //       (Route<dynamic> route) => false);
                                  // });
                                },
                              );
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: ColorConstants.active),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "LIVE",
                              style: TextStyle(color: ColorConstants.red),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * .6,
                        // color: Colors.amber,
                        child: Container(
                          child: Builder(
                            builder: (context) {
                                var socketProvider = context.watch<SocketProvider>();
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  socketProvider.urls == null
                                      ? Center(
                                          child:
                                              CircularProgressIndicator.adaptive(),
                                        )
                                      : Container(
                                          width:
                                              MediaQuery.of(context).size.height *
                                                  7,
                                          height:
                                              MediaQuery.of(context).size.height *
                                                  .6,
                                          child:
                                           Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
socketProvider.urls == null
              ? Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : Container(
                height: 450,
                width: MediaQuery.of(context).size.width * .7,
                child: VideoPlayer(socketProvider.controller!))
                  // VideoPlayer(socketProvider.controller!),
                  // _ControlsOverlay(controller: socketProvider.controller),
                  // VideoProgressIndicator(socketProvider.controller!, allowScrubbing: true),
                ],
              ),
                                          //  JkVideoControlPanel(
                                          //   socketProvider.controller!,
                                          //   showClosedCaptionButton: false,
                                          //   showFullscreenButton: false,
                                          //   showVolumeButton: false,
                                          // )
                                          ),
                                  // Container(
                                  //   height: 200,
                                  //   child: ScrollConfiguration(
                                  //     behavior: MyCustomScrollBehavior(),
                                  //     child: ListView.builder(
                                  //         itemCount: images.length,
                                  //         shrinkWrap: true,
                                  //         physics: AlwaysScrollableScrollPhysics(),
                                  //         scrollDirection: Axis.horizontal,
                                  //         itemBuilder: (context, index) {
                                  //           return Padding(
                                  //             padding: const EdgeInsets.all(8.0),
                                  //             child: Stack(
                                  //               children: [
                                  //                 Container(
                                  //                   height: 200,
                                  //                   width: 180,
                                  //                   decoration: BoxDecoration(
                                  //                       color: Colors.black,
                                  //                       image: DecorationImage(
                                  //                           image: NetworkImage(
                                  //                               images[index]),
                                  //                           fit: BoxFit.cover)),
                                  //                 ),
                                  //                 Container(
                                  //                   height: 200,
                                  //                   width: 180,
                                  //                   color: Colors.black12,
                                  //                 ),
                                  //                 const Positioned(
                                  //                     bottom: 15,
                                  //                     left: 10,
                                  //                     child: Icon(
                                  //                       Icons.play_arrow,
                                  //                       color: Colors.white,
                                  //                     )),
                                  //                 Positioned(
                                  //                     bottom: 15,
                                  //                     right: 10,
                                  //                     child: Container(
                                  //                       color: Colors.black87,
                                  //                       child: const Padding(
                                  //                         padding:
                                  //                             EdgeInsets.all(3.0),
                                  //                         child: Text(
                                  //                           "05:20",
                                  //                           style: TextStyle(
                                  //                               color: Colors.white,
                                  //                               fontSize: 11),
                                  //                         ),
                                  //                       ),
                                  //                     )),
                                  //               ],
                                  //             ),
                                  //           );
                                  //         }),
                                  //   ),
                                  // ),
                                ],
                              );
                            }
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .3,
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Latest Playlist",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: ColorConstants.black),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Playlist()));
                                },
                                child: Text(
                                  "See All",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: ColorConstants.black),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Builder(builder: (context) {
                            var provider = context.watch<PlaylistProvider>();

                            return provider.isLoading
                                ? Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  )
                                : Column(
                                    children: [
                                      for (int i = 0;
                                          i < provider.playlist!.data.length;
                                          i++)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0),
                                          child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .3,
                                              decoration: BoxDecoration(
                                                color: provider.playlist!.data[i].isRunning ? Colors.green[100] :Colors.white,
                                                  border: Border.all(
                                                      color: ColorConstants
                                                          .white)),
                                              child: ListTile(
                                                onTap: (){
                                                  
nav.push(context,   DetailsPlaylist(
                                                  title: provider.playlist!.data[i].name,
                                                  playlistID: provider.playlist!.data[i].id,
                                                  videos: provider.playlist!.data[i].
                                                    videos
                                                ),);   
                                                },
                                                contentPadding: EdgeInsets.zero,
                                                leading: Container(
                                                    height: 40,
                                                    width: 40,
                                                    child: Icon(Icons.list),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        // image: const DecorationImage(
                                                        //     image: NetworkImage(
                                                        //         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHXxIYiq_T7DYdZfqlUfa9Lg3P2cM6xiR7177e-UtoOhKZejmht22JGGrcvfm1TM02V3U&usqp=CAU"),
                                                        //     fit: BoxFit
                                                        //         .fitHeight)
                                                        )
                                                                ),
                                                // subtitle: Marquee(
                                                //     direction: Axis.horizontal,
                                                //     directionMarguee:
                                                //         DirectionMarguee
                                                //             .oneDirection,
                                                //     child: Container(
                                                //       width: 200,
                                                      // child: const Text(
                                                      //   "Lay Down Your Demo Scratch Vocal. ...Embellish. ...Lay Down Your Vocals. ...Put A Mix On It. ...",
                                                        // maxLines: 1,
                                                        // overflow: TextOverflow
                                                        //     .ellipsis,
                                                      // ),
                                                    // )),
                                                title:  Container(
                                                    width: MediaQuery.of(context).size.width * 0.20,
                                                    child: Text(
                                                    provider.playlist!.data[i].name ,
                                                      style: TextStyle(
                                                          color:
                                                              ColorConstants.black,
                                                          fontSize: 16),
                                                            maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                    ),
                                                  ),
                                                trailing:  
                                                 InkWell(
                                                  onTap: ()async{
                                                    var provider = context.read<PlaylistProvider>();
                                                   var message = await provider.runPlaylist(context, provider.playlist!.data[i].id);
                                                   if (message != null) {
                                                     showSnackBar(context, message);
                                                   }
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Icon(
                                                      Icons.play_arrow,
                                                      color:
                                                          ColorConstants.lightGreen,
                                                    ),
                                                  ),
                                                ),
                                              
                                            
                                          
                                              )),
                                        ),
                                 
                                    ],
                                  );
                          }),
                        ]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
