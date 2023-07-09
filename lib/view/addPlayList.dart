import 'dart:convert';

import 'package:egypt_american/view/addVideoScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constant.dart';
import '../utils/customTile.dart';

class AddPlayListScreen extends StatefulWidget {
  const AddPlayListScreen({super.key});

  @override
  State<AddPlayListScreen> createState() => _AddPlayListScreenState();
}

class _AddPlayListScreenState extends State<AddPlayListScreen> {
  TextEditingController title = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   title.dispose();
  // }
  List playLists = [];
  // var sp = SharedPreferences.getInstance();
  // String jsonPlayList = jsonEncode(playLists.asMap());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text(
          "Playlists",
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Add Playlist'),
                content: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: title,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Playlist Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        )),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Process the form data here
                        Navigator.of(context).pop();

                        playLists.add(
                          title.text,
                        );
                      }
                      title.clear();
                      setState(() {});
                    },
                    child: Text('Submit'),
                  ),
                ],
              );
            },
          );
          child:
          Text('Open Form');
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < playLists.length; i++)
              customTile(
                  child: Image(image: AssetImage('assets/images/avatar.jpg')),
                  title: '${playLists[i]}',
                  iconColor: kWarningColor,
                  subtitle: '${i + 1}',
                  icon: Icons.delete,
                  tileTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) =>
                            AddVideoScreen(playListName: playLists[i]),
                      ),
                    );
                  },
                  iconTap: () {
                    playLists.removeAt(i);
                    setState(() {});
                  }),
          ],
        ),
      ),
    );
  }
}
