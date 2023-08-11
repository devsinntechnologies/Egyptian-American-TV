// To parse this JSON data, do
//
//     final linksModel = linksModelFromJson(jsonString);

import 'dart:convert';

LinksModel linksModelFromJson(String str) => LinksModel.fromJson(json.decode(str));

String linksModelToJson(LinksModel data) => json.encode(data.toJson());

class LinksModel {
    String currentVideoLink;
    String nextVideoLink;

    LinksModel({
        required this.currentVideoLink,
        required this.nextVideoLink,
    });

    factory LinksModel.fromJson(Map<String, dynamic> json) => LinksModel(
        currentVideoLink: json["currentVideoLink"],
        nextVideoLink: json["nextVideoLink"],
    );

    Map<String, dynamic> toJson() => {
        "currentVideoLink": currentVideoLink,
        "nextVideoLink": nextVideoLink,
    };
}
