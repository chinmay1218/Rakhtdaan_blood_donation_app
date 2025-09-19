import 'package:bb_ui/bloodfacts.dart';
import 'package:bb_ui/bloodrequest.dart';
import 'package:bb_ui/blood_donate.dart';
import 'package:bb_ui/registration.dart';
import 'package:bb_ui/bloodsearch.dart';
import 'package:bb_ui/splash_screen.dart';
import 'package:bb_ui/filter_blood.dart';
import 'package:bson/bson.dart';
import 'package:flutter/material.dart';
import 'package:bb_ui/login.dart';
import 'package:bb_ui/homescreen.dart';
import 'dbHelper/mongodb.dart';
import 'package:mongo_dart/mongo_dart.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  ObjectId objectId = ObjectId();
  // String objectIdString = objectId.toHexString();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
      ),
      debugShowCheckedModeBanner: false,
    routes:{
        '/':(context)=> const Splash(),
        '/login':(context)=> const Login(),
        '/register':(context)=> const Register(),
        '/home':(context)=> const HomeScreen(name: '', email: '', phone: '', gender: '', bgroup: '', dob: null, place: '',),
        '/survey':(context)=> const Survey(),
        '/request':(context)=> const BloodRequest(),
        '/donate':(context)=>const Donate(),
        '/search':(context)=>const BloodSearch(),
        '/facts':(context)=>const BloodFacts(),
    },
    );
  }
}
//
// void main(){
//   runApp( MaterialApp(
//     debugShowCheckedModeBanner: false,
//     routes:{
//       '/':(context)=> const Splash(),
//       '/login':(context)=> const Login(),
//       '/register':(context)=> const Register(),
//       '/home':(context)=> const HomeScreen(),
//       '/survey':(context)=> const Survey()
//     },
//   ));
// }
