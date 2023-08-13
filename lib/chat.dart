import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final chatController = TextEditingController();

  String? response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: chatController,
          ),
          ElevatedButton(
              onPressed: () async{
                var url = Uri.parse("https://talkai.info/chat/send/");
                var body = {
                  "message": chatController.text,
                  "temperature": 1,
                  "frequency_penalty": 0,
                  "type": "chat"
                };
              var responseData  = await http.post(url, body: jsonEncode(body));
              debugger();

              print(responseData.body);
              },
              child: Text("SEND")),
          Text(response ?? "No result"),
        ],
      ),
    );
  }
}
