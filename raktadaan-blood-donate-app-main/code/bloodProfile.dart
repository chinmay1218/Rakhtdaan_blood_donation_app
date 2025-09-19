import 'package:flutter/material.dart';
import 'dbHelper/JSONshcemaModel.dart';
import 'dbHelper/mongodb.dart';
import 'package:bb_ui/registration.dart';
class donorProfile extends StatefulWidget {
  const donorProfile({super.key});

  @override
  State<donorProfile> createState() => _donorProfileState();
}
class _donorProfileState extends State<donorProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
      ),
      // body: SafeArea(
      //   child:
      //   }
    );
  }
}
