import 'dart:async';
import 'dart:developer';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_token_service/agora_token_service.dart';
import 'package:egy_us_tv_admin/controller/service/api_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

const appId = "25c38680de234f618db5b23c3500c5fe";
var token = "";
const channel = "demo";

   bool _localUserJoined = false;
   bool muted =false;
class AgoraMyPreview extends StatefulWidget {
//  final String channelId;
//  final String token;
//  final DateTime endTime;
   @override
   State<AgoraMyPreview> createState() => _AgoraMyPreviewState();
 }
 
 class _AgoraMyPreviewState extends State<AgoraMyPreview> {
   int? _remoteUid;
   bool _localUserJoined = false;
   bool muted =false;
   late RtcEngine _engine;
   @override
   void initState() {
     super.initState();
     getDynamicToken();
     initAgora();
   }


   getDynamicToken()async{
    var myToken = await ApiManager.getRTCToken(context);


  if(myToken != null){
    setState(() {
      token = myToken;
    });
  }
    print(token);
   }
 
 
   Future<void> initAgora() async {
     // retrieve permissions
     await [Permission.microphone, Permission.camera].request();
 
     //create the engine
     _engine = createAgoraRtcEngine();
     await _engine.initialize(const RtcEngineContext(
       appId: appId,
       channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
     ));
 
     _engine.registerEventHandler(
       RtcEngineEventHandler(
         onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
           debugPrint("local user ${connection.localUid} joined");
           setState(() {
             _localUserJoined = true;
           });
         },
         onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
           debugPrint("remote user $remoteUid joined");
           setState(() {
             _remoteUid = remoteUid;
           });
         },
         onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
           debugPrint("remote user $remoteUid left channel");
           setState(() {
             _remoteUid = null;
           });
         },
         onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
           debugPrint('[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
         },
       ),
     );
 
     await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
     await _engine.enableVideo();
     await _engine.startPreview();
 
     await _engine.joinChannel(
       token: token,
       channelId: channel,
       uid: 0,
       options: const ChannelMediaOptions(),
     );
   }
 
 
 
   // Create UI with local view and remote view
   @override
   Widget build(BuildContext context) {
     return Scaffold(
 
       body: WillPopScope(
         onWillPop: ()async {
           await _engine.release();
           await _engine.leaveChannel();
           return true;
         },
         child: Stack(
           children: [
             Center(
               child: _remoteVideo(),
             ),
             // Positioned(
             //   right: 50,
             //   top:20,
             //   child: SlideCountdown(
             //     duration: const Duration(days: 2),
             //     countUp: false,
             //   ),
             // )
             // CountdownTimer(
             //   endTime: DateTime(2023, 9, 21, 17, 28, 00).millisecondsSinceEpoch,
             //   textStyle: TextStyle(fontSize: 30, color: Colors.pink),
             //   endWidget: CountdownTimer(
             //     endTime: DateTime(2023, 9, 21, 17, 29, 00).millisecondsSinceEpoch,
             //     textStyle: TextStyle(fontSize: 30, color: Colors.black87),
             //     onEnd: (){
             //       log(
             //       "Hello"
             //     );
             //
             //     },
             //
             //   ),
             //
             // ),
            //  Positioned(
            //    top: 50,
            //      left: 20,
            //      child: CountdownTimer(endDateTime: widget.endTime))
        
             Align(
               alignment: Alignment.topRight,
               child: Container(
                 margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
 
                 width: 100,
                 height: 150,
                 child: Center(
                   child: _localUserJoined
                       ? ClipRRect(
                     borderRadius:BorderRadius.circular(10),
                         child: AgoraVideoView(
                     controller: VideoViewController(
                         rtcEngine: _engine,
                         canvas: const VideoCanvas(uid: 0),
                     ),
                   ),
                       )
                       :  CircularProgressIndicator(color:Colors.red,),
                 ),
               ),
             ),
 
 
 
 
             _toolbar(),
           ],
         ),
       ),
     );
   }
 
 
   // Display remote user's video
   Widget _remoteVideo() {
       if (_remoteUid != null) {
       return AgoraVideoView(
         controller: VideoViewController.remote(
           rtcEngine: _engine,
           canvas: VideoCanvas(uid: _remoteUid),
           connection:  RtcConnection(channelId: channel),
         ),
       );
     } else {
     return  Center(child: Text("You are only in this meeting!"));
     }
   }
 
 
 
   Widget _toolbar() {
     return Container(
       alignment: Alignment.bottomCenter,
       padding: const EdgeInsets.symmetric(vertical: 48),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
           RawMaterialButton(
             onPressed: _onToggleMute,
             child: Icon(
               muted ? Icons.mic_off : Icons.mic,
               color: muted ? Colors.white : Colors.red,
               size: 20.0,
             ),
             shape: CircleBorder(),
             elevation: 2.0,
             fillColor: muted ? Colors.blueAccent : Colors.white,
             padding: const EdgeInsets.all(12.0),
           ),
           RawMaterialButton(
             onPressed: () => _onCallEnd(context),
             child: Icon(
               Icons.call_end,
               color: Colors.white,
               size: 35.0,
             ),
             shape: CircleBorder(),
             elevation: 2.0,
             fillColor: Colors.redAccent,
             padding: const EdgeInsets.all(15.0),
           ),
           RawMaterialButton(
             onPressed: _onSwitchCamera,
             child: Icon(
               Icons.switch_camera,
               color: Colors.red,
               size: 20.0,
             ),
             shape: CircleBorder(),
             elevation: 2.0,
             fillColor: Colors.white,
             padding: const EdgeInsets.all(12.0),
           )
         ],
       ),
     );
   }
   void _onToggleMute() {
     setState(() {
       muted = !muted;
     });
     _engine.muteLocalAudioStream(muted);
   }
   void _onSwitchCamera() {
     _engine.switchCamera();
   }
 
   void _onCallEnd(BuildContext context)async {
     Navigator.pop(context);
     await _engine.release();
       await _engine.leaveChannel();
 
 
 
 
       // await _engine.leave().then(value) =>
 
   }
 }

 
 String generateToken(
     {String? time, String? date, String? channel, String? duration}) {
   const appId = '184bc2e5b2ba4568a4f9e15a5482d69e';
   const appCertificate = '4f52fb8e2b0448918125a9a23f6760a7';
 
   const role = RtcRole.publisher;
 
   DateTime data = DateFormat("yyyy-MM-dd h:mma")
       .parse("${date!} ${time!.split(" ").join()}");
 
   // final expirationInSeconds = 3600;
   final currentTimestamp = data.millisecondsSinceEpoch ~/ 1000;
   final expireTimestamp = currentTimestamp +
       (Duration(minutes: int.parse(duration!) + 15).inSeconds);
 
   final token = RtcTokenBuilder.build(
     appId: appId,
     appCertificate: appCertificate,
     channelName: channel!,
     uid: "0",
     role: role,
     expireTimestamp: expireTimestamp,
   );
 
   log("SubhanAli " + token);
 
   return token;
 }
 
 int generateTimeStamp(String date, String time) {
   print(time);
 
   DateTime dte = DateTime.parse(date);
   DateTime tme = DateFormat("hh:mma").parse(time.split(" ").first +
       time.split(" ").last); // think this will work better for you
 // format date
   int finalTime = dte
           .add(Duration(hours: tme.hour, minutes: tme.minute))
           .millisecondsSinceEpoch ~/
       1000;
 
   return finalTime;
 }