import 'dart:developer';
import 'package:bb_ui/dbHelper/constant.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:bb_ui/filter_blood.dart';
import 'JSONschemaModel_requests.dart';
import 'JSONshcemaModel.dart';
class MongoDatabase {
 static var db, collection , collection_2;
 static String? bloodGroup;
 static String? location;
 static void accessBloodGroup(String? selectedBloodType, String? selectedLocation) {
   bloodGroup = selectedBloodType;
   print(bloodGroup); // Now, bloodGroup contains the value of selectedBloodType
   location = selectedLocation;
   print(location);// Now, location contains the value of selectedlocation
 }

 static Future<List<Map<String, dynamic>>> getQueryData() async{
    // var location = '$city,${district}';
     final data = await collection.find(
         where.eq('userbloodgroup', bloodGroup).eq('userlocation', location))
         .toList();
     return data;
  }
 static Future<List<Map<String, dynamic>>> getRequestData() async{
   final data = await collection_2.find().toList();
   return data;
 }

 static connect() async {
  db = await Db.create(MONGO_URL);
  await db.open();
  inspect(db);
  var status = db.serverStatus();
  print(status);
  collection = db.collection(USER_COLLECTION);
  collection_2 = db.collection(USER_COLLECTION_2);
  print(await collection.find().toList());
  print(await collection_2.find().toList());
 }

 static Future<String> insert(MongoDbModel data) async {
  try {
   var result = await collection.insertOne(data.toJson());
   if (result.isSuccess) {
    return "Data Stored!!!!!!!!!";
   } else {
    return "Data NOT stored Bhaiiii";
   }
  } catch (e) {
   print(e.toString());
   return e.toString();
  }
 }
 static Future<String> request(MongoDbModelRequest data) async {
    try {
       var result = await collection_2.insertOne(data.toJson());
       if (result.isSuccess) {
         return "Data Stored!!!!!!!!!";
       } else {
         return "Data NOT stored Bhaiiii";
       }
     } catch (e) {
       print(e.toString());
       return e.toString();
     }
   }
}