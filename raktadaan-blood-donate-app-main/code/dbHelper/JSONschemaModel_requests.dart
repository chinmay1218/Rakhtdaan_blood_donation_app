// To parse this JSON data, do
//
//     final mongoDbModelRequest = mongoDbModelRequestFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:bson/bson.dart';

MongoDbModelRequest mongoDbModelRequestFromJson(String str) => MongoDbModelRequest.fromJson(json.decode(str));
String mongoDbModelRequestToJson(MongoDbModelRequest data) => json.encode(data.toJson());

class MongoDbModelRequest {
  final Object? id;
  final String bloodType;
  final String firstName;
  final String phoneNumber;
  final String bloodGroup;
  final String date;
  final String unit;
  final String hospital;
  final String location;
  final bool isCritical;

  MongoDbModelRequest({
    required this.id,
    required this.bloodType,
    required this.firstName,
    required this.phoneNumber,
    required this.bloodGroup,
    required this.date,
    required this.unit,
    required this.hospital,
    required this.location,
    required this.isCritical,
  });

  factory MongoDbModelRequest.fromJson(Map<String, dynamic> json) => MongoDbModelRequest(
    id: json["_id"],
    bloodType: json["bloodType"],
    firstName: json["firstName"],
    phoneNumber: json["phoneNumber"],
    bloodGroup: json["bloodGroup"],
    date: json["date"],
    unit: json["unit"],
    hospital: json["hospital"],
    location: json["location"],
    isCritical: json["isCritical"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "bloodType": bloodType,
    "firstName": firstName,
    "phoneNumber": phoneNumber,
    "bloodGroup": bloodGroup,
    "date": date,
    "unit": unit,
    "hospital": hospital,
    "location": location,
    "isCritical": isCritical,
  };
}
