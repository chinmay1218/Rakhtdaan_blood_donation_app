import 'package:bb_ui/dbHelper/JSONschemaModel_requests.dart';
import 'package:bb_ui/dbHelper/mongodb.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
class Donate extends StatefulWidget {
  const Donate({super.key});

  @override
  State<Donate> createState() => _DonateState();
}

class _DonateState extends State<Donate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Requests"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: requests(),
    );
  }

  Widget requests() {
    return SafeArea(
        child: FutureBuilder(
          future: MongoDatabase.getRequestData(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Text("Loading Requests...")
                    ]
                ),
              );
            }
            else {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return displayRequests(
                          MongoDbModelRequest.fromJson(snapshot.data[index])
                      );
                    }
                );
              }
              else {
                return const Center(
                  child: Text("Data not Found"),
                );
              }
            }
          }
        )
    );
  }
}
Widget displayRequests(MongoDbModelRequest data){
  return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.red, // Set the border color here
                  width: 3.0, // Set the border width here
                ),
              ),
            ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
      children: [Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name : ${data.firstName}",
           style: TextStyle(fontSize: 16),
            ),
            SizedBox( height: 3,),
            Text(
              "Blood Group : ${data.bloodGroup} (${data.bloodType}) ${data.unit} Units",
                style: TextStyle(fontSize: 16),
            ),
            Text(
              "Location : ${data.hospital}\n"
                  "${data.location}",
                style: TextStyle(fontSize: 16),
            ),
            SizedBox( height: 3,),
            Text(
              "Needed Within : ${data.date}",
                style: TextStyle(fontSize: 16),
            ),
            Text(
              "Contact No : ${data.phoneNumber}",
                style: TextStyle(fontSize: 16),
            ),
            SizedBox( width: 20,),
            Row(
              children:[
            ElevatedButton.icon(
                onPressed: () => shareRequest(data),
                icon: Icon(Icons.share_outlined),
                label: Text('share')
            ),
            SizedBox(width: 10,),
            ElevatedButton.icon(
                onPressed: () => acceptRequest(data),
                icon: Icon(
                    Icons.chat,
                   color: Colors.green,
                ),
                label: Text(
                    'chat',
                  style: TextStyle(color: Colors.green),
                )
            )
              ]
            )
          ]
      ),

      ]
    )
    )
          )
  );
}

acceptRequest(MongoDbModelRequest data) {
  var phoneNumber = {data.phoneNumber};
  launchUrlString("sms:$phoneNumber");
}


shareRequest(MongoDbModelRequest data){
  var msg1 = "Request for  ${data.bloodGroup} Blood🩸\n"
      "Name : ${data.firstName}\n"
      "Blood Group : ${data.bloodGroup} (${data.bloodType}) ${data.unit} Units\n"
      "Location :  ${data.hospital} , ${data.location}\n"
      "Needed Within : ${data.date}\n"
      "Contact No : ${data.phoneNumber}\n"
      "By Team Raktdaan";
  Share.share(msg1);
}
