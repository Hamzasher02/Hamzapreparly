// To parse this JSON data, do
//
//     final subjectsModel = subjectsModelFromJson(jsonString);

import 'dart:convert';

List<SubjectsModel> subjectsModelFromJson(String str) => List<SubjectsModel>.from(json.decode(str).map((x) => SubjectsModel.fromJson(x)));

String subjectsModelToJson(List<SubjectsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubjectsModel {
  SubjectsModel({
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
  Catagoryid? catagoryid;
  String? name;
  String? slug;
  bool? status;
  String? subjecticon;
  String? subjectbanner;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory SubjectsModel.fromJson(Map<String, dynamic> json) => SubjectsModel(
    id: json["_id"],
    catagoryid: json["catagoryid"] == null ? null : Catagoryid.fromJson(json["catagoryid"]),
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
    "catagoryid": catagoryid?.toJson(),
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

class Catagoryid {
  Catagoryid({
    this.id,
    this.name,
    this.slug,
    this.fullName,
    this.categoryicon,
    this.categorybanner,
    this.parentId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? name;
  String? slug;
  dynamic fullName;
  String? categoryicon;
  String? categorybanner;
  String? parentId;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory Catagoryid.fromJson(Map<String, dynamic> json) => Catagoryid(
    id: json["_id"],
    name: json["name"],
    slug: json["slug"],
    fullName: json["Full_name"],
    categoryicon: json["categoryicon"],
    categorybanner: json["categorybanner"],
    parentId: json["parentId"],
    status: json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "slug": slug,
    "Full_name": fullName,
    "categoryicon": categoryicon,
    "categorybanner": categorybanner,
    "parentId": parentId,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
