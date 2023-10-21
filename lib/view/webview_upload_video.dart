import 'package:egy_us_tv_admin/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_windows/webview_windows.dart';
import 'package:window_manager/window_manager.dart';


class WebviewUploadVideo extends StatefulWidget {
  final playListID, order;

  WebviewUploadVideo({this.order,this.playListID});
  @override
  State<WebviewUploadVideo> createState() => _WebviewUploadVideoState();
}

class _WebviewUploadVideoState extends State<WebviewUploadVideo> {
  final _controller = WebviewController();

  final navigatorKey = GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }
   Future<WebviewPermissionDecision> _onPermissionRequested(
      String url, WebviewPermissionKind kind, bool isUserInitiated) async {
    final decision = await showDialog<WebviewPermissionDecision>(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('WebView permission requested'),
        content: Text('WebView has requested permission \'$kind\''),
        actions: <Widget>[
          TextButton(
            onPressed: () =>
                Navigator.pop(context, WebviewPermissionDecision.deny),
            child: const Text('Deny'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.pop(context, WebviewPermissionDecision.allow),
            child: const Text('Allow'),
          ),
        ],
      ),
    );

    return decision ?? WebviewPermissionDecision.none;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.active,
        title: Text("Upload Video"),
      ),
      body:  Webview(
                          _controller,
                          permissionRequested: _onPermissionRequested,
                        ),
                        // StreamBuilder(
                        //     stream: _controller.loadingState,
                        //     builder: (context, snapshot) {
                        //       if (snapshot.hasData &&
                        //           snapshot.data == LoadingState.loading) {
                        //         return LinearProgressIndicator();
                        //       } else {
                        //         return SizedBox();
                        //       }
                        //     })
    );
  }

   Future<void> initPlatformState() async {
    // Optionally initialize the webview environment using
    // a custom user data directory
    // and/or a custom browser executable directory
    // and/or custom chromium command line flags
    //await WebviewController.initializeEnvironment(
    //    additionalArguments: '--show-fps-counter');

    try {
      await _controller.initialize();
      // _subscriptions.add(_controller.url.listen((url) {
      //   _textController.text = url;
      // }));

      // _subscriptions
      //     .add(_controller.containsFullScreenElementChanged.listen((flag) {
      //   debugPrint('Contains fullscreen element: $flag');
        // windowManager.setFullScreen(flag);
      // }));

      await _controller.setBackgroundColor(Colors.transparent);
      await _controller.setPopupWindowPolicy(WebviewPopupWindowPolicy.deny);
      await _controller.loadUrl('http://localhost:5173?id=${widget.playListID}&order=${widget.order}');

      if (!mounted) return;
      setState(() {});
    } on PlatformException catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text('Error'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Code: ${e.code}'),
                      Text('Message: ${e.message}'),
                    ],
                  ),
                  actions: [
                    TextButton(
                      child: Text('Continue'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ));
      });
    }
  }
}