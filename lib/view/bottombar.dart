// import 'package:egy_us_tv_admin/config/color.dart';
// import 'package:egy_us_tv_admin/view/home.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'playlist.dart';

// int selectedItemPosition = 0;

// class BottomBarTab extends StatefulWidget {
//   const BottomBarTab({Key? key}) : super(key: key);
//   @override
//   _BottomBarTabState createState() => _BottomBarTabState();
// }

// class _BottomBarTabState extends State<BottomBarTab> {
//   final BorderRadius _borderRadius = const BorderRadius.only(
//     topLeft: Radius.circular(25),
//     topRight: Radius.circular(25),
//   );
//   EdgeInsets padding = const EdgeInsets.fromLTRB(0, 2, 0, 0);
//   void onTabTapped(int index) {
//     setState(() {
//       selectedItemPosition = index;
//     })
//   }

//   bool popval = false;
//   final List _pages = [
//     Home(),
//     Playlist(),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if (selectedItemPosition == 0) {
//           final shouldPop = await showDialog<bool>(
//             barrierDismissible: false,
//             context: context,
//             builder: (context) {
//               return CupertinoAlertDialog(
//                 title: const Text(
//                   'Are you sure to exit app?',
//                 ),
//                 actions: [
//                   CupertinoDialogAction(
//                     onPressed: () {
//                       setState(() {
//                         popval = true;
//                       });
//                       Navigator.of(context).pop(true);
//                     },
//                     child: Text(
//                       'Yes',
//                       style: TextStyle(
//                           color: ColorConstants.primaryColor,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w700),
//                     ),
//                   ),
//                   CupertinoDialogAction(
//                     onPressed: () {
//                       Navigator.of(context).pop(false);
//                     },
//                     child: const Text(
//                       'No',
//                       style: TextStyle(
//                           color: Colors.red,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w700),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           );
//           return Future.value(popval);
//         } else {
//           onTabTapped(0);
//           return Future.value(false);
//         }
//       },
//       child: Scaffold(
//         extendBodyBehindAppBar: true,
//         resizeToAvoidBottomInset: true,
//         extendBody: true,
//         body: _pages[selectedItemPosition],
//         bottomNavigationBar: BottomAppBar(
//           height: 50,
//           elevation: 10,
//           color: Colors.white,
//           shape: CircularNotchedRectangle(), //shape of notch
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Expanded(
//                   child: Container(
//                     // decoration: BoxDecoration(
//                     //     border: Border.all(
//                     //         color: selectedItemPosition == 0
//                     //             ? ColorConstants.active
//                     //             : ColorConstants.colorTextLight)),
//                     child: InkWell(
//                       onTap: () {
//                         selectedItemPosition = 0;
//                         setState(() {});
//                       },
//                       child: Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               selectedItemPosition == 0
//                                   ? Icons.home
//                                   : Icons.home_outlined,
//                               color: selectedItemPosition == 0
//                                   ? ColorConstants.active
//                                   : Colors.black,
//                               size: 20,
//                             ),
//                             Text(
//                               "Home",
//                               style: TextStyle(
//                                 color: selectedItemPosition == 0
//                                     ? ColorConstants.active
//                                     : Colors.black,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: InkWell(
//                     onTap: () {
//                       selectedItemPosition = 1;
//                       setState(() {});
//                     },
//                     child: Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             selectedItemPosition == 1
//                                 ? Icons.playlist_play
//                                 : Icons.playlist_add_outlined,
//                             color: selectedItemPosition == 1
//                                 ? ColorConstants.active
//                                 : Colors.black,
//                             size: 20,
//                           ),
//                           Text(
//                             "Playlist",
//                             style: TextStyle(
//                               color: selectedItemPosition == 1
//                                   ? ColorConstants.active
//                                   : Colors.black,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
