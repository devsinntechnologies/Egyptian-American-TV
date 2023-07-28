// import 'package:flutter/material.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:permission_handler/permission_handler.dart';

// class AdminLiveStreamScreen extends StatefulWidget {
//   @override
//   _AdminLiveStreamScreenState createState() => _AdminLiveStreamScreenState();
// }

// class _AdminLiveStreamScreenState extends State<AdminLiveStreamScreen> {
//   bool _isStreaming = false;

//   @override
//   void initState() {
//     super.initState();
//     _initializeAgora();
//   }

//   Future<void> _initializeAgora() async {
//     // Request permission to access the camera and microphone
//     await Permission.camera.request();
//     await Permission.microphone.request();

//     // Initialize the Agora engine
//     AgoraRtcEngine.create('YOUR_AGORA_APP_ID');
//     await AgoraRtcEngine.enableVideo();
//     await AgoraRtcEngine.startPreview();
//   }

//   Future<void> _startStreaming() async {
//     // Join the Agora channel for live streaming
//     await AgoraRtcEngine.setChannelProfile(ChannelProfile.LiveBroadcasting);
//     await AgoraRtcEngine.setClientRole(ClientRole.Broadcaster);
//     await AgoraRtcEngine.joinChannel(null, 'YOUR_AGORA_CHANNEL_NAME', null, 0);
    
//     setState(() {
//       _isStreaming = true;
//     });
//   }

//   Future<void> _stopStreaming() async {
//     // Leave the Agora channel and stop streaming
//     await AgoraRtcEngine.leaveChannel();
//     await AgoraRtcEngine.stopPreview();
//     AgoraRtcEngine.destroy();

//     setState(() {
//       _isStreaming = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Admin Live Stream'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _isStreaming
//                 ? Container(
//                     width: 200,
//                     height: 300,
//                     child: AgoraRtcEngine.createNativeView((viewId) {
//                       AgoraRtcEngine.setupLocalVideo(viewId, VideoRenderMode.Hidden);
//                       AgoraRtcEngine.startPreview();
//                     }),
//                   )
//                 : Text('Click "Start" to begin streaming'),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _isStreaming ? _stopStreaming : _startStreaming,
//               child: Text(_isStreaming ? 'Stop' : 'Start'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }