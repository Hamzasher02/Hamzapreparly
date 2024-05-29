// To parse this JSON data, do
//
//     final chaptersModel = chaptersModelFromJson(jsonString);

import 'dart:convert';

List<ChaptersModel> chaptersModelFromJson(String str) => List<ChaptersModel>.from(json.decode(str).map((x) => ChaptersModel.fromJson(x)));

String chaptersModelToJson(List<ChaptersModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChaptersModel {
  ChaptersModel({
    this.id,
    this.subjectid,
    this.name,
    this.chapterPic,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  Subjectid? subjectid;
  String? name;
  String? chapterPic;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory ChaptersModel.fromJson(Map<String, dynamic> json) => ChaptersModel(
    id: json["_id"],
    subjectid: json["subjectid"] == null ? null : Subjectid.fromJson(json["subjectid"]),
    name: json["name"],
    chapterPic: json["chapterPic"],
    status: json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "subjectid": subjectid?.toJson(),
    "name": name,
    "chapterPic": chapterPic,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Subjectid {
  Subjectid({
    this.id,
    this.catagoryid,
    this.name,
    this.slug,
    this.status,
    this.subjecticon,
    this.subjectbanner,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? catagoryid;
  String? name;
  String? slug;
  bool? status;
  String? subjecticon;
  String? subjectbanner;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory Subjectid.fromJson(Map<String, dynamic> json) => Subjectid(
    id: json["_id"],
    catagoryid: json["catagoryid"],
    name: json["name"],
    slug: json["slug"],
    status: json["status"],
    subjecticon: json["subjecticon"],
    subjectbanner: json["subjectbanner"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "catagoryid": catagoryid,
    "name": name,
    "slug": slug,
    "status": status,
    "subjecticon": subjecticon,
    "subjectbanner": subjectbanner,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
