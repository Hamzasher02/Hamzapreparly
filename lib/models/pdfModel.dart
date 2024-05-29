// To parse this JSON data, do
//
//     final pdfModel = pdfModelFromJson(jsonString);

import 'dart:convert';

PdfModel pdfModelFromJson(String str) => PdfModel.fromJson(json.decode(str));

String pdfModelToJson(PdfModel data) => json.encode(data.toJson());

class PdfModel {
  PdfModel({
    this.pdfList,
  });

  List<PdfList>? pdfList;

  factory PdfModel.fromJson(Map<String, dynamic> json) => PdfModel(
    pdfList: json["pdfList"] == null ? [] : List<PdfList>.from(json["pdfList"]!.map((x) => PdfList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pdfList": pdfList == null ? [] : List<dynamic>.from(pdfList!.map((x) => x.toJson())),
  };
}

class PdfList {
  PdfList({
    this.id,
    this.name,
    this.myFile,
    this.chapterid,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? name;
  String? myFile;
  Chapterid? chapterid;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory PdfList.fromJson(Map<String, dynamic> json) => PdfList(
    id: json["_id"],
    name: json["name"],
    myFile: json["myFile"],
    chapterid: json["chapterid"] == null ? null : Chapterid.fromJson(json["chapterid"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "myFile": myFile,
    "chapterid": chapterid?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Chapterid {
  Chapterid({
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
  String? subjectid;
  String? name;
  String? chapterPic;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory Chapterid.fromJson(Map<String, dynamic> json) => Chapterid(
    id: json["_id"],
    subjectid: json["subjectid"],
    name: json["name"],
    chapterPic: json["chapterPic"],
    status: json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "subjectid": subjectid,
    "name": name,
    "chapterPic": chapterPic,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
