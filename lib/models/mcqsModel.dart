// To parse this JSON data, do
//
//     final mcqsModel = mcqsModelFromJson(jsonString);

import 'dart:convert';

McqsModel mcqsModelFromJson(String str) => McqsModel.fromJson(json.decode(str));

String mcqsModelToJson(McqsModel data) => json.encode(data.toJson());

class McqsModel {
  McqsModel({
    this.questionList,
  });

  List<QuestionList>? questionList;

  factory McqsModel.fromJson(Map<String, dynamic> json) => McqsModel(
    questionList: json["questionList"] == null ? [] : List<QuestionList>.from(json["questionList"]!.map((x) => QuestionList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "questionList": questionList == null ? [] : List<dynamic>.from(questionList!.map((x) => x.toJson())),
  };
}

class QuestionList {
  QuestionList({
    this.id,
    this.chapterid,
    this.questionId,
    this.question,
    this.slug,
    this.correctAnswer,
    this.incorrectAnswer,
    this.v,
  });

  String? id;
  Chapterid? chapterid;
  String? questionId;
  String? question;
  String? slug;
  String? correctAnswer;
  List<String>? incorrectAnswer;
  int? v;

  factory QuestionList.fromJson(Map<String, dynamic> json) => QuestionList(
    id: json["_id"],
    chapterid: json["chapterid"] == null ? null : Chapterid.fromJson(json["chapterid"]),
    questionId: json["questionId"],
    question: json["question"],
    slug: json["slug"],
    correctAnswer: json["correct_answer"],
    incorrectAnswer: json["incorrect_answer"] == null ? [] : List<String>.from(json["incorrect_answer"]!.map((x) => x)),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "chapterid": chapterid?.toJson(),
    "questionId": questionId,
    "question": question,
    "slug": slug,
    "correct_answer": correctAnswer,
    "incorrect_answer": incorrectAnswer == null ? [] : List<dynamic>.from(incorrectAnswer!.map((x) => x)),
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
