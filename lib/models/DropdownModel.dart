class DropdownModel {
  String? id;
  String? subname; // Change from 'name' to 'subname'
  String? parentId;
  String? categoryIcon;
  String? categoryBanner;
  String? fullName;
  List<DropdownModel>? children;
  String? categoryType;
  bool? isActive;

  DropdownModel({
    this.id,
    this.subname, // Change from 'name' to 'subname'
    this.parentId,
    this.categoryIcon,
    this.categoryBanner,
    this.fullName,
    this.children,
    this.categoryType,
    this.isActive,
  });

  factory DropdownModel.fromJson(Map<String, dynamic> json) => DropdownModel(
        id: json["_id"],
        subname: json["subname"], // Change from 'name' to 'subname'
        parentId: json["categoryId"]["_id"],
        categoryIcon: json["logo"],
        categoryBanner: json["exambanner"],
        fullName: json["categoryId"]["examname"],
        children: json["children"] == null
            ? []
            : List<DropdownModel>.from(
                json["children"].map((x) => DropdownModel.fromJson(x))),
        categoryType: json["categoryType"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "examname": subname, // Change from 'name' to 'subname'
        "categoryId": {"_id": parentId},
        "logo": categoryIcon,
        "exambanner": categoryBanner,
        "full_name": fullName,
        "children": children == null
            ? []
            : List<dynamic>.from(children!.map((x) => x.toJson())),
        "categoryType": categoryType,
        "isActive": isActive,
      };
}
