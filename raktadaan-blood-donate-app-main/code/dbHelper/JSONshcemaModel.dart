// To parse this JSON data, do
//
//     final mongoDbModel = mongoDbModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:bson/bson.dart';

MongoDbModel mongoDbModelFromJson(String str) => MongoDbModel.fromJson(json.decode(str));
String mongoDbModelToJson(MongoDbModel data) => json.encode(data.toJson());

class MongoDbModel {
  final ObjectId? id;
  final String username;
  final String userphoneno;
  final String useremail;
  final String userpass;
  final String usergen;
  final String userbloodgroup;
  final DateTime userdob;
  final String userlocation;

  MongoDbModel({
    required this.id,
    required this.username,
    required this.userphoneno,
    required this.useremail,
    required this.userpass,
    required this.usergen,
    required this.userbloodgroup,
    required this.userdob,
    required this.userlocation,
  });

  factory MongoDbModel.fromJson(Map<String, dynamic> json) => MongoDbModel(
    id: json["_id"],
    username: json["username"],
    userphoneno: json["userphoneno"],
    useremail: json["useremail"],
    userpass: json["userpass"],
    usergen: json["usergen"],
    userbloodgroup: json["userbloodgroup"],
    userdob: DateTime.parse(json["userdob"]),
    userlocation: json["userlocation"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "username": username,
    "userphoneno": userphoneno,
    "useremail": useremail,
    "userpass": userpass,
    "usergen": usergen,
    "userbloodgroup": userbloodgroup,
    "userdob": "${userdob.year.toString().padLeft(4, '0')}-${userdob.month.toString().padLeft(2, '0')}-${userdob.day.toString().padLeft(2, '0')}",
    "userlocation": userlocation,
  };
}
