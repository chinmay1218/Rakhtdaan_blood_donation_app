import 'package:bb_ui/dbHelper/JSONshcemaModel.dart';
import 'package:bb_ui/dbHelper/mongodb.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BloodSearch extends StatefulWidget {
  const BloodSearch({super.key});

  @override
  State<BloodSearch> createState() => _BloodSearchState();
}

class _BloodSearchState extends State<BloodSearch> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("Donors Details"),
      backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: MongoDatabase.getQueryData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            else {
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return displayData(
                      MongoDbModel.fromJson(snapshot.data[index])
                    );
                  },
                );
              }
              else{
                return const Center(
                  child: Text("Data not Found"),
                );
              }
            }
          },
        ),
      ),
    );
  }

  Widget displayData(MongoDbModel data) {
    return Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.red,
              radius: 30,
              child: Text(
                "${data.userbloodgroup}",
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(width: 10), // Adjust the spacing between CircleAvatar and Text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${data.username}",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 5),
                Text(
                  "${data.usergen}",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 5),
                // Text(
                //   "${data.userphoneno}",
                //   style: TextStyle(fontSize: 18),
                // ),
                SizedBox(height: 3),
                Text(
                  "${data.userlocation}",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            // const SizedBox( width: 150,),
            Spacer(),
            ElevatedButton(
              onPressed: () => launchUrlString("tel:${data.userphoneno}"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.all(10)
              ),
              child:const Icon(
                Icons.phone,
                color: Colors.green,
                size: 40,
              ),
            ),// Add space between user information and phone icon
          ],
        ),
      ],
    )
    );
  }
}

