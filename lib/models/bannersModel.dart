// To parse this JSON data, do
//
//     final bannersModel = bannersModelFromJson(jsonString);

import 'dart:convert';

BannersModel bannersModelFromJson(String str) =>
    BannersModel.fromJson(json.decode(str));

String bannersModelToJson(BannersModel data) => json.encode(data.toJson());

class BannersModel {
  BannersModel({
    this.bannerList,
  });

  List<BannerList>? bannerList;

  factory BannersModel.fromJson(List<dynamic> json) => BannersModel(
        bannerList: json.map((x) => BannerList.fromJson(x)).toList(),
      );

  Map<String, dynamic> toJson() => {
        "bannerList": bannerList == null
            ? []
            : List<dynamic>.from(bannerList!.map((x) => x.toJson())),
      };
}

class BannerList {
  BannerList({
    this.id,
    this.name,
    this.title,
    this.description,
    this.bannerImage,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? name;
  String? title;
  String? description;
  List<String>? bannerImage;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory BannerList.fromJson(Map<String, dynamic> json) => BannerList(
        id: json["_id"],
        name: json["name"],
        title: json["title"],
        description: json["description"],
        bannerImage: List<String>.from(json["bannerImage"].map((x) => x)),
        isActive: json["isActive"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "title": title,
        "description": description,
        "bannerImage": bannerImage == null
            ? []
            : List<dynamic>.from(bannerImage!.map((x) => x)),
        "isActive": isActive,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
