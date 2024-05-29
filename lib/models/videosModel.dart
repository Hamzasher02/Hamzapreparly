// To parse this JSON data, do
//
//     final videosModel = videosModelFromJson(jsonString);

import 'dart:convert';

VideosModel videosModelFromJson(String str) => VideosModel.fromJson(json.decode(str));

String videosModelToJson(VideosModel data) => json.encode(data.toJson());

class VideosModel {
  VideosModel({
    this.videoList,
  });

  List<VideoList>? videoList;

  factory VideosModel.fromJson(Map<String, dynamic> json) => VideosModel(
    videoList: json["videoList"] == null ? [] : List<VideoList>.from(json["videoList"]!.map((x) => VideoList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "videoList": videoList == null ? [] : List<dynamic>.from(videoList!.map((x) => x.toJson())),
  };
}

class VideoList {
  VideoList({
    this.id,
    this.name,
    this.description,
    this.videoUrl,
    this.chapterid,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? name;
  String? description;
  String? videoUrl;
  Chapterid? chapterid;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory VideoList.fromJson(Map<String, dynamic> json) => VideoList(
    id: json["_id"],
    name: json["name"],
    description: json["description"],
    videoUrl: json["videoUrl"],
    chapterid: json["chapterid"] == null ? null : Chapterid.fromJson(json["chapterid"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "description": description,
    "videoUrl": videoUrl,
    "chapterid": chapterid?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Chapterid {
  Chapterid({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory Chapterid.fromJson(Map<String, dynamic> json) => Chapterid(
    id: json["_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
  };
}
