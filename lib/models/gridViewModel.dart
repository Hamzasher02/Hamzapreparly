// To parse this JSON data, do
//
//     final gridViewModel = gridViewModelFromJson(jsonString);

import 'dart:convert';

List<GridViewModel> gridViewModelFromJson(String str) =>
    List<GridViewModel>.from(
        json.decode(str).map((x) => GridViewModel.fromJson(x)));

String gridViewModelToJson(List<GridViewModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GridViewModel {
  String? id;
  String? name; // Change from "examname" to "name"
  String? parentId;
  String? categoryicon; // Change from "categoryicon" to "logo"
  String? categorybanner; // Change from "categorybanner" to "exambanner"
  String? fullName; // Change from "Full_name" to "full_name"
  List<GridViewModel>? children;
  String? categoryType;
  bool? status; // Change from "status" to "isActive"

  GridViewModel({
    this.id,
    this.name,
    this.parentId,
    this.categoryicon,
    this.categorybanner,
    this.fullName,
    this.children,
    this.categoryType,
    this.status,
  });

  factory GridViewModel.fromJson(Map<String, dynamic> json) => GridViewModel(
        id: json["_id"],
        name: json["examname"],
        parentId: json["categoryId"],
        categoryicon: json["logo"],
        categorybanner: json["exambanner"],
        fullName: json["full_name"],
        children: json["children"] == null
            ? []
            : List<GridViewModel>.from(
                json["children"].map((x) => GridViewModel.fromJson(x))),
        categoryType: json["categoryType"],
        status: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "examname": name,
        "categoryId": parentId,
        "logo": categoryicon,
        "exambanner": categorybanner,
        "full_name": fullName,
        "children": children == null
            ? []
            : List<dynamic>.from(children!.map((x) => x.toJson())),
        "categoryType": categoryType,
        "isActive": status,
      };
}
