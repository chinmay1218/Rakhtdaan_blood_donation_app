import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:bb_ui/dbHelper/mongodb.dart';
import 'bloodsearch.dart';

class Survey extends StatefulWidget {
  const Survey({super.key});

  @override
  State<Survey> createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BloodSearchFilter(
          onBloodTypeSelected: (selectedBloodType, selectedLocation) {
        setState(() {
          MongoDatabase.accessBloodGroup(selectedBloodType, selectedLocation);
        });
      }),
    );
  }
}

class BloodSearchFilter extends StatefulWidget {
  final Function(String?, String?) onBloodTypeSelected;
  BloodSearchFilter({super.key, required this.onBloodTypeSelected});

  @override
  _BloodSearchFilterState createState() => _BloodSearchFilterState();
}

class _BloodSearchFilterState extends State<BloodSearchFilter> {
  bool isSelected = false;
  String selectedBloodType = 'A+';
  String? selectedDistrict;
  String? selectedCity;

  @override
  void initState() {
    super.initState();
    selectedDistrict = null;
    selectedCity = null;
  }

  List<String> bloodTypes = ['A+', 'B+', 'AB+', 'O+', 'A-', 'B-', 'AB-', 'O-'];
  List<String> districts = [
    'Bagalkot',
    'Banglore',
    'Belagum',
    'Bellary',
    'Bidar',
    'Bijapur',
    'Chikkmaglur',
    'Chitradurga',
    'Chamrajnagar',
    'Dakshina Kannada',
    'Davangere',
    'Dharwad',
    'Gadag',
    'Gulbarga',
    'Hassan',
    'Haveri',
    'Haveri',
    'Kolar',
    'Koppal',
    'Mysore',
    'Raichur',
    'Shivamogga',
    'Tumkur',
    'Udupi',
    'Uttara Kannada',
  ]; // Add more districts as needed
  Map<String, List<String>> citiesByDistrict = {
    'Bagalkot':['Bagalkot','Badami','Bilagi','Hungund','Mudhol'],
    'Banglore':['Anekal','Banshankari', 'Banglore','Basavangudi','Chickpet','Electronic city','Hossur','Jaynagar','Malleswaram'],
    'Belagum' : [ 'Athani', 'Bailhongal', 'Belagavi', 'Chikkodi', 'Gokak', 'Hukkeri', 'Khanapur', 'Ramdurg' , 'Raibhag',  'Saundatti' ],
    'Bellary':['Bellary','Hospet','Kampli','Kottur','Sandur'],
    'Bidar':['Bidar','Aurad','Basavakalyan','Bhalki','Chittekoppa'],
    'Bijapur':['Bijapur','Basavanbagewadi','Indi','Muddebehal','Talikota'],
    'Chikkmaglur':['Chikkmaglur'],
    'Chitradurga':['Chitradurga','Hosdurga','Challakere','Hiriyur','Hollakere',],
    'Chamrajnagar':[ 'Chamrajnagar'],
    'Dakshina Kannada':[ 'Dakshina Kannada','Manglore','Bantwal','Moodbidri','Puttur'],
    'Davangere':['Davangere'],
    'Dharwad' : ['Dharwad' , 'Hubali', 'Kalaghatgi', 'Kundgol', 'Annigeri', 'Navalgund'],
    'Gadag' : [ 'Gadag', 'Nargund', 'Ron', 'Shirahatti', 'Mundargi','Lakshmeshwar','Gajendragad'],
    'Gulbarga':['Aland','Gulbarga','Chincholli','Chitapura','Jewargi','Gurmatkal','Shahapur','Yadgeri'],
    'Hassan':['Hassan','Alur','Belur','Arakalgud','Arsikere','Channarayanpattana'],
    'Haveri':['Haveri','Bankapura','Byadgi','Hangal','Rannebinnur','Savanur'],
    'Kolar':['Kolar','Chikballapur','Bangarpet','Malur','Mulbagal','Chintamani'],
    'Koppal' : ['Koppal', 'Gangavathi' , 'Kushtagi' ,'Yelburga' , 'Kanakagiri' , 'Karatagi'],
    'Mysore':['Mysore','Mandya','Bannur','Hebbalu','Khrinarajaagar','Nanjanagudda','piriyapatna'],
    'Raichur':['Raichur','Hatti','Devadurga','Mannvi','Mudgal','Sindhanur','Gangavati'],
    'Shivamogga':['Shivamogga','Bandravati','Hosnagar','Jog Falls','Sagar','Siralkoppa','Tirthalli'],
    'Tumkur':['Tumkur','Adityapatna','Chikkanayaknahalli','Gubbi','Sira'],
    'Udupi':['Udupi','Karkal','Kundapura','Mallar','Saligram','Yanagudde'],
    'Uttara Kannada' : ['Sirsi', 'Yellapur', 'Dandeli','Karwar', 'Ankola', 'Kumta','Honnavar', 'Bhatkal'],
  };

  Map<String, bool> isSelectedMap = {
    'A+': false,
    'B+': false,
    'AB+': false,
    'O+': false,
    'A-': false,
    'B-': false,
    'AB-': false,
    'O-': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Blood Search'),
          backgroundColor: Colors.red,
        ),
        body: SingleChildScrollView(
            child: Container(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 8.0, right: 8.0, bottom: 0.0, left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Select Blood Group:'),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: (bloodTypes.length / 4).ceil(),
                  itemBuilder: (context, index) {
                    int startIndex = index * 4;
                    int endIndex = (index + 1) * 4;
                    List<String> rowBloodTypes = bloodTypes.sublist(
                      startIndex,
                      endIndex > bloodTypes.length
                          ? bloodTypes.length
                          : endIndex,
                    );

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: rowBloodTypes.map((type) {
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedBloodType = type;
                                  isSelectedMap
                                      .updateAll((key, value) => false);
                                  isSelectedMap[type] = true;
                                });
                                searchBlood();
                              },
                              child: Text(
                                type,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              style: ButtonStyle(
                                elevation:
                                    MaterialStateProperty.resolveWith<double>(
                                        (Set<MaterialState> states) {
                                  // Set the elevation based on button state (pressed or not)
                                  return isSelectedMap[type] == true
                                      ? 4.0
                                      : 2.0; // Adjust elevation values as needed
                                }),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState> states) {
                                    if (isSelectedMap[type] == true) {
                                      // Color when the button is pressed
                                      return Colors.red;
                                    } else {
                                      // Color when the button is not pressed
                                      return Colors.white;
                                    }
                                  },
                                ),
                                foregroundColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.disabled)) {
                                      return Colors.grey;
                                    } else {
                                      return selectedBloodType == type
                                          ? Colors.blue
                                          : null;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
                SizedBox(height: 16),
                Text('Select District:'),
                DropdownButton<String>(
                  value: selectedDistrict,
                  hint: Text('--Select Your District--'),
                  onChanged: (district) {
                    setState(() {
                      selectedDistrict = district!;
                      selectedCity = null;
                    });
                    searchBlood();
                  },
                  items: districts.map((district) {
                    return DropdownMenuItem<String>(
                      value: district,
                      child: Text(district),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),
                Text('Select City:'),
                DropdownButton<String>(
                  value: selectedCity,
                  hint: Text('--Select Your City--'),
                  onChanged: (city) {
                    setState(() {
                      selectedCity = city!;
                    });
                    searchBlood();
                  },
                  items: citiesByDistrict[selectedDistrict ?? '']?.map((city) {
                        return DropdownMenuItem<String>(
                          value: city,
                          child: Text(city),
                        );
                      }).toList() ??
                      [],
                ),
                SizedBox(
                  height: 300,
                ),
                Container(
                    height: 50,
                    child: SizedBox(
                      child: ElevatedButton(
                        onPressed: () {
                          // Action when the button is pressed
                          searchBlood();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BloodSearch()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(MediaQuery.of(context).size.width,
                                MediaQuery.of(context).size.width),
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero),
                            padding: EdgeInsets.zero),
                        child: Text(
                          'Search',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        )));
  }

  void searchBlood() {
    var bloodGroup = selectedBloodType;
    var district = selectedDistrict;
    var city = selectedCity;
    print('Searching for $bloodGroup blood in $city, $district');
    var location = "$city,$district";
    widget.onBloodTypeSelected(bloodGroup, location);
  }
}
//   Widget content() {
//     return const Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(vertical: 60),
//           child: Center(
//             child: Icon(
//               Icons.bloodtype,
//               size: 100,
//               color: Colors.redAccent,
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         Text("Please Pick Your\n    Blood Group",
//             style: TextStyle(fontSize: 16)),
//         SizedBox(
//           height: 20,
//         ),
//         // Row(
//         //   mainAxisAlignment: MainAxisAlignment.center,
//         //   children: [
//         //     bloodType(),
//         //   ],
//         // )
//       ],
//     );
//   }
//
//   // Widget typeRow() {
//   //   return Row(
//   //     mainAxisAlignment: MainAxisAlignment.center,
//   //     children: [
//   //       bloodType(),
//   //     ],
//   //   );
//   // }
//   Widget bloodType(){
//     return Container(
//       decoration: BoxDecoration(color: Colors.red.shade200),
//       width: 180,
//       height: 90,
//       child: const Text("A+"),
//     );
//   }

// body: Padding(
//   padding: const EdgeInsets.all(16.0),
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text('Select Blood Type:'),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: bloodTypes.map((type) {
//           return ElevatedButton(
//             onPressed: () {
//               setState(() {
//                 // isSelected = true;
//                 selectedBloodType = type;
//                 isSelectedMap.updateAll((key, value) => false);
//                 isSelectedMap[type] = true;
//               });
//               searchBlood();
//             },
//             child: Text(type,
//               style: TextStyle(color: Colors.black),
//             ),
//             style: ButtonStyle(
//             backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
//                   if (isSelectedMap[type] == true) {
//                     // Color when the button is pressed
//                     return Colors.red;
//                   }
//                   else {
//                       // Color when the button is not pressed
//                          return Colors.white;
//                   }
//                   },),
//               foregroundColor :  MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states){
//                 if(states.contains(MaterialState.disabled)){
//                         return Colors.grey;
//                 } else{
//                   return selectedBloodType == type ? Colors.blue : null;
//                   }
//                 }),
//           ),);
//         }).toList(),
//       ),
