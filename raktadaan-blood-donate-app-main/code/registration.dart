// import 'dart:js';

import 'package:bson/bson.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:bb_ui/homescreen.dart';
import 'package:intl/intl.dart';
import 'package:bb_ui/dbHelper/JSONshcemaModel.dart';
import 'package:mongo_dart/mongo_dart.dart' as M; // should set variable for mongo_dart package not for JOSN schema model
import 'package:bb_ui/homescreen.dart';
import 'dbHelper/JSONshcemaModel.dart';
import 'dbHelper/mongodb.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}
//parameters for gender
    enum SingingCharacter { male, female, others }
    SingingCharacter? _character = SingingCharacter.male;
    String singingCharacterToString(SingingCharacter character) {
     return character.toString().split('.').last;
    }
class _RegisterState extends State<Register> {
  final _formkey = GlobalKey<FormState>();
  bool _passwordVisible = true;
  bool _isLoading = false;

  void initState() {
    _passwordVisible = false;
  }
  // final SingingCharacter? _character = SingingCharacter.male;
  //drop down list for bloodgroup
  String? _selectedBloodGroup;
  List<String> bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
    // Add more blood groups as needed
  ];

  //drop down list for district
  String? _selectedDistrict;
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
  ];
  String? _selectedCity;
  Map<String , List<String>> citiesByDistrict = {
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
  late String selectedLocation;
  // drop down list for cities
  // String? _selectedCity ;
  // List<String> cities= [
  //   'Dharwad',
  //   'Uttara Kannada',
  //   'Gadag',
  //   'Belagum',
  //   'Koppal'
  // ];
  //controller for text fields
  var nameController = new TextEditingController();
  var phoneController = new TextEditingController();
  var emailController = new TextEditingController();
  var passController = new TextEditingController();
  TextEditingController dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        dateController.text = DateFormat('yyyy-MM-dd')
            .format(picked); // Format the date as needed
      });
    }
  }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading ? _buildLoading() : heading(),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [
       CircularProgressIndicator(),
          SizedBox(height: 20,),
          Text(
            'Welcome to Raktdaan...', // Add your loading text here
            style: TextStyle(fontSize: 24),
          )
        ]
      )// CircularProgressIndicator while loading
    );
  }

  Widget heading() {
    return SingleChildScrollView(
        child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 150,
                decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0))),
                child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.app_registration_sharp,
                        size: 50,
                        color: Colors.white,
                      ),
                      Text("Get registered to Raktdaan",
                          style: TextStyle(fontSize: 24, color: Colors.white)),
                    ]),
              ),
              registerForm(),
            ]
        )
    );
  }

  Widget registerForm() {
    return Form(
      key: _formkey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please fill form completely';
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Mobile Number",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.phone_rounded),
                ),
                validator: (value) {
                  final validMobileRegex = RegExp(r'^[0-9]{10}$');
                  if (value!.isEmpty || !validMobileRegex.hasMatch(value)) {
                    return 'Please enter a valid phone number';
                  }
                  // if (!RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value)) {
                  //   return 'Please enter a valid phone number';
                  // }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.mail_rounded)),
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: passController,
                keyboardType: TextInputType.text,
                // controller: _userPasswordController,
                obscureText:
                !_passwordVisible,
                //This will obscure text dynamically
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  // Here is key idea
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      // color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter password';
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Gender",
                    style: TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                  ListTile(
                    title: const Text('Male'),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.male,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Female'),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.female,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Others'),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.others,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              // Widget for radio button
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Blood Group',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.bloodtype_rounded),
                ),
                value: _selectedBloodGroup,
                items: bloodGroups.map((String bloodType) {
                  return DropdownMenuItem<String>(
                    value: bloodType,
                    child: Text(bloodType),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedBloodGroup = newValue;
                    if (_selectedBloodGroup != null) {
                      print('Selected blood group: $_selectedBloodGroup');
                    }
                  }
                  );
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please fill form completely';
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: dateController,
                decoration: InputDecoration(
                  labelText: "Date of Birth",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () {
                      _selectDate(context);
                    },
                  ),
                ),
                readOnly: true,
                // This makes the TextField non-editable
                onTap: () {
                  _selectDate(context);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Plese fill form completely';
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Location",
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'District',
                  border: OutlineInputBorder(),
                  // suffixIcon: Icon(Icons),
                ),
                value: _selectedDistrict,
                items: districts.map((String district) {
                  return DropdownMenuItem<String>(
                    value: district,
                    child: Text(district),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedDistrict = newValue;
                    if (_selectedDistrict != null) {
                      print('Selected District: $_selectedDistrict');
                    }
                    _selectedCity = null;
                  });
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Plese fill form completely';
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                  // suffixIcon: Icon(Icons),
                ),
                value: _selectedCity,
                items:  citiesByDistrict[_selectedDistrict ?? '']?.map((city)  {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCity= newValue;
                    if (_selectedCity != null) {
                      print('Selected District: $_selectedCity');
                    }
                  });
                    selectedLocation = _selectedCity! + ','+ _selectedDistrict!;
                    print(
                        'Location : $selectedLocation' );

                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Plese fill form completely';
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 200,
                height: 50,
                child: TextButton(
                  onPressed: () {
                    // Navigate to the 'HomeScreen' when the button is clicked
                    final form = _formkey.currentState;
                    if (form!.validate()) {
                      _formData(
                          nameController.text,
                          phoneController.text,
                          emailController.text,
                          passController.text,
                          singingCharacterToString(_character!),
                          _selectedBloodGroup!,
                          DateTime.parse(dateController.text),
                          selectedLocation!
                      );
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => HomeScreen()),
                      // );
                      _submitForm();
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(Colors.redAccent),
                    shape:
                    MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "Submit",
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      )
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ]
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    setState(() {
      _isLoading = true; // Set loading state to true when submitting form
    });
    await Future.delayed(Duration(seconds: 2));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  HomeScreen(
          name: nameController.text,
          email: emailController.text,
          phone: phoneController.text,
          gender:singingCharacterToString(_character!),
          bgroup :_selectedBloodGroup!,
          dob:  DateTime.parse(dateController.text),
          place:selectedLocation!,
      )),
    );
    setState(() {
      _isLoading = false; // Set loading state to false after navigation
    });
  }
}



  Future<void> _formData(String name, String phoneno, String email, String pass,
      String singingCharacter, String selectedBloodGroup, DateTime dob,
      String selectedLocation) async {
    var id = M.ObjectId();
    final donordata = MongoDbModel(
        id: id,
        username: name,
        userphoneno: phoneno,
        useremail: email,
        userpass: pass,
        usergen: singingCharacter,
        userbloodgroup: selectedBloodGroup,
        userdob: dob,
        userlocation: selectedLocation
    );
    var result = await MongoDatabase.insert(donordata);
    // ScaffoldMessenger.of(context)
    //     .showSnackBar(SnackBar(content: Text("Inserted Id ${id.$oid}")));
  }

// class RadioExample extends StatefulWidget {
//   const RadioExample({super.key});
//
//   @override
//   State<RadioExample> createState() => _RadioExampleState();
// }
//
// class _RadioExampleState extends State<RadioExample> {
//   SingingCharacter? _character = SingingCharacter.male;
//
//   String singingCharacterToString(SingingCharacter character) {
//     return character.toString().split('.').last;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         ListTile(
//           title: const Text('Male'),
//           leading: Radio<SingingCharacter>(
//             value: SingingCharacter.male,
//             groupValue: _character,
//             onChanged: (SingingCharacter? value) {
//               setState(() {
//                 _character = value;
//               });
//                var gen = singingCharacterToString(_character!);
//             },
//           ),
//         ),
//         ListTile(
//           title: const Text('Female'),
//           leading: Radio<SingingCharacter>(
//             value: SingingCharacter.female,
//             groupValue: _character,
//             onChanged: (SingingCharacter? value) {
//               setState(() {
//                 _character = value;
//               });
//               var gen = singingCharacterToString(_character!);
//             },
//           ),
//         ),
//         ListTile(
//           title: const Text('Others'),
//           leading: Radio<SingingCharacter>(
//             value: SingingCharacter.others,
//             groupValue: _character,
//             onChanged: (SingingCharacter? value) {
//               setState(() {
//                 _character = value;
//               });
//               var gen = singingCharacterToString(_character!);
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

//     Row(
//       children:[
//       Icon(Icons.person_2_outlined, size: 35,color: Colors.redAccent,
//       ),
//       SizedBox( width: 5),
//       const Text("Name", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),)
//       ]),
// const SizedBox( height: 10,),
// Container(
//   decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(10),
//     border: Border.all(width: 0.5, color: Colors.grey)
//   ),
//   child: TextField(
//       decoration: const InputDecoration(border: InputBorder.none),
//       onChanged: (value) {},
//   ),
// ),
//     const SizedBox( height: 20,),
//     const Row(
//         children:[
//           Icon(Icons.bloodtype_outlined, size: 35,color: Colors.redAccent,
//           ),
//           SizedBox( width: 5),
//           Text("Blood Group", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),)
//         ]),
// const SizedBox( height: 10,),
//  Container(
//      decoration: BoxDecoration(
//      borderRadius: BorderRadius.circular(10),
//       border: Border.all(width: 0.5, color: Colors.grey)
//    ),
//      child: TextField(
//     decoration: const InputDecoration(border: InputBorder.none),
//     onChanged: (value) {},
//    ),
//  ),
//     SizedBox( height: 20,),
//     Row(
//         children:[
//           Icon(Icons.phone_outlined, size: 35,color: Colors.redAccent,
//           ),
//           SizedBox( width: 5),
//           const Text("Contact No", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),)
//         ]),
//     const SizedBox( height: 10,),
//     Container(
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(width: 0.5, color: Colors.grey)
//       ),
//       child: TextField(
//         decoration: const InputDecoration(border: InputBorder.none),
//         onChanged: (value) {},
//       ),
//     ),
//     SizedBox( height: 20,),
//     Row(
//         children:[
//           Icon(Icons.location_on_outlined, size: 35,color: Colors.redAccent,
//           ),
//           SizedBox( width: 5),
//           const Text("Location", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),)
//         ]),
//     const SizedBox( height: 10,),
//     Container(
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(width: 0.5, color: Colors.grey)
//       ),
//       child: TextField(
//         decoration: const InputDecoration(border: InputBorder.none),
//         onChanged: (value) {},
//       ),
//     ),
