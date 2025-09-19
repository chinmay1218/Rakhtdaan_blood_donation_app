import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bb_ui/dbHelper/JSONschemaModel_requests.dart';
import 'package:flutter/services.dart';
import 'package:mongo_dart/mongo_dart.dart' as M; // should set variable for mongo_dart package not for JOSN schema model
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'blood_donate.dart';
import 'dbHelper/mongodb.dart';
import 'homescreen.dart';
class BloodRequest extends StatefulWidget {
  const BloodRequest({super.key});

  @override
  State<BloodRequest> createState() => _BloodRequestState();
}

class _BloodRequestState extends State<BloodRequest> {
  final _form2key = GlobalKey<FormState>();
  String selectedBloodType = 'Blood';
  String selectedBloodGroup = 'A+';
  bool isCritical = false;
  bool agreedToTerms = false;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController hospitalController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController additionalNoteController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate:  DateTime(DateTime.now().year + 2),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        dateController.text = DateFormat('dd-MM-yyyy').format(picked); // Format the date as needed
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
      appBar: AppBar(
          title: Text('Blood Request'), backgroundColor: Colors.red
      ),
      body:
      SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _form2key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButton<String>(
                    value: selectedBloodType,
                    onChanged: (value) {
                      setState(() {
                        selectedBloodType = value!;
                        if (selectedBloodType != null) {
                          print('Selected blood Type: $selectedBloodType');
                        }
                      });
                    },
                    items: ['Blood', 'Platelets'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Patient First Name',
                    ),
                    controller: firstNameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please fill the form completely!';
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Attendee Mobile Number',
                      // icon: Icon(Icons.phone_android)
                    ),
                    controller: mobileNumberController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      final validMobileRegex = RegExp(r'^[0-9]{10}$');
                      if (value!.isEmpty || !validMobileRegex.hasMatch(value)) {
                        return 'Please enter phone number correctly!';
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Blood Group',
                      // icon: Icon(Icons.bloodtype_rounded),
                    ),
                    value: selectedBloodGroup,
                    items: ['A+', 'B+', 'O+', 'AB+', 'A-', 'B-', 'O-', 'AB-']
                        .map((String bloodType) {
                      return DropdownMenuItem<String>(
                        value: bloodType,
                        child: Text(bloodType),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedBloodGroup = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.datetime,
                    controller: dateController,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Allow only numbers
                    ],
                    decoration:  InputDecoration(
                        labelText: 'Required Date',
                       border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () {
                           _selectDate(context);
                        },
                      ),
                    ),
                    readOnly: true,
                    onTap: () {
                      _selectDate(context);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please mention the Required Date';
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Units',
                        hintText: 'mention number of units required'
                      // icon: Icon(Icons.ad_units_outlined)
                    ),
                    keyboardType: TextInputType.number,
                    controller: unitController,
                    validator: (value) {
                      final validUnitRegex = RegExp(r'^[0-9]{1}$');
                      if (value!.isEmpty || !validUnitRegex.hasMatch(value)) {
                        return 'Please fill form completely';
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Hospital / Blood Bank Name',
                      // icon: Icon(Icons.location_on_outlined)
                    ),
                    controller: hospitalController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please fill form completely';
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Please add Location',
                      // icon: Icon(Icons.location_on_outlined)
                    ),
                    controller: locationController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please fill form completely';
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text('Critical'),
                      Switch(
                        value: isCritical,
                        onChanged: (value) {
                          setState(() {
                            isCritical = value;
                          });
                        },
                      ),
                    ],
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Additional Note to Potential Donors'),
                    controller: additionalNoteController,
                    maxLines: 3,
                  ),
                  FormField<bool>(
                      builder: (state) {
                        return Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Checkbox(
                                    value: agreedToTerms,
                                    onChanged: (value) {
                                      setState(() {
                                        agreedToTerms = value!;
                                      });
                                    }),
                                const Text('I have read and agree to these'),
                              ],
                            ),
                            //display error in matching theme
                            Text(
                              state.errorText ?? '',
                              style: TextStyle(
                                  color: Theme
                                      .of(context)
                                      .colorScheme
                                      .error
                              ),
                            )
                          ],
                        );
                      },
                      //output from validation will be displayed in state.errorText (above)
                      validator: (value) {
                        if (!agreedToTerms) {
                          return 'You need to accept terms';
                        }
                      }
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        // shape: CircleBorder(),
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30.0), // Adjust the radius as needed
                        ),
                      ),
                      onPressed: () {
                        final form = _form2key.currentState;
                        if (form!.validate()) {
                          _requestData(
                              selectedBloodType ,
                            firstNameController.text,
                            mobileNumberController.text,
                            selectedBloodGroup,
                            dateController.text,
                            unitController.text,
                            hospitalController.text,
                            locationController.text,
                            isCritical,
                          );
                          _showRequestDialog(); // Call function to show Awesome Dialog
                        }

                        // Access the entered values using controllers or state variables
                      },
                      child: Container(
                        width: 200, // Set width as desired
                        height: 50,
                        alignment: Alignment.center,
                        child: Text('Send Request',
                          style: TextStyle(fontSize: 18, color: Colors.white),),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
      ),
    );
  }

  //
  // Widget content() {
  //   return  SingleChildScrollView(
  //           child: Padding(
  //             padding: const EdgeInsets.all(20.0),
  //             child: Form(
  //               key: _form2key,
  //               child:Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 DropdownButton<String>(
  //                   value: selectedBloodType,
  //                   onChanged: (value) {
  //                     setState(() {
  //                       selectedBloodType = value!;
  //                       if (selectedBloodType != null) {
  //                         print('Selected blood Type: $selectedBloodType');
  //                       }
  //                     });
  //                   },
  //                   items: ['Blood', 'Platelets'].map((String value) {
  //                     return DropdownMenuItem<String>(
  //                       value: value,
  //                       child: Text(value),
  //                     );
  //                   }).toList(),
  //                 ),
  //                 const SizedBox( height: 10),
  //                 TextFormField(
  //                   decoration: const InputDecoration(
  //                     labelText: 'Patient First Name',
  //                   ),
  //                   controller: firstNameController,
  //                   validator: (value) {
  //                     if(value!.isEmpty){
  //                       return 'Please fill the form completely!';
  //                     }
  //                   },
  //                 ),
  //                 const SizedBox( height: 10),
  //                 TextFormField(
  //                   decoration: const InputDecoration(
  //                       labelText: 'Attendee Mobile Number',
  //                       // icon: Icon(Icons.phone_android)
  //                   ),
  //                   controller: mobileNumberController,
  //                   keyboardType: TextInputType.phone,
  //                   validator: (value) {
  //                     if(value!.isEmpty || value.length != 10){
  //                       return 'Please enter phone number correctly!';
  //                     }
  //                   },
  //                 ),
  //                 const SizedBox( height: 10),
  //                 DropdownButtonFormField<String>(
  //                   decoration: const InputDecoration(
  //                     labelText: 'Blood Group',
  //                       // icon: Icon(Icons.bloodtype_rounded),
  //                   ),
  //                   value: selectedBloodGroup,
  //                   items: ['A+', 'B+', 'O+', 'AB+', 'A-', 'B-', 'O-', 'AB-']
  //                       .map((String bloodType) {
  //                     return DropdownMenuItem<String>(
  //                       value: bloodType,
  //                       child: Text(bloodType),
  //                     );
  //                   }).toList(),
  //                   onChanged: (String? value) {
  //                     setState(() {
  //                       selectedBloodGroup = value!;
  //                     });
  //                   },
  //                 ),
  //                 const SizedBox( height: 10),
  //                 TextFormField(
  //                   decoration: const InputDecoration(
  //                       labelText: 'Required Date',
  //                       hintText: 'dd/mm/yyyy'
  //                       // icon: Icon(Icons.calendar_month)
  //                   ),
  //                   keyboardType: TextInputType.datetime,
  //                   controller: DateController,
  //                   validator: (value) {
  //                     if(value!.isEmpty){
  //                       return 'Please mention the Required Date';
  //                     }
  //                   },
  //                 ),
  //                 const SizedBox( height: 10),
  //                 TextFormField(
  //                   decoration: const InputDecoration(
  //                       labelText: 'Select Units',
  //                       hintText: 'mention number of units required'
  //                       // icon: Icon(Icons.ad_units_outlined)
  //                   ),
  //                   keyboardType: TextInputType.number,
  //                   controller: unitController,
  //                   validator: (value) {
  //                     if(value!.isEmpty){
  //                       return 'Please fill form completely';
  //                     }
  //                   },
  //                 ),
  //                 const SizedBox( height: 10),
  //                 TextFormField(
  //                   decoration: InputDecoration(
  //                       labelText: 'Please Select Location',
  //                       // icon: Icon(Icons.location_on_outlined)
  //                   ),
  //                   controller: locationController,
  //                   validator: (value) {
  //                     if(value!.isEmpty){
  //                       return 'Please fill form completely';
  //                     }
  //                   },
  //                 ),
  //                 const SizedBox( height: 10),
  //                 Row(
  //                   children: [
  //                     Text('Critical'),
  //                     Switch(
  //                       value: isCritical,
  //                       onChanged: (value) {
  //                         setState(() {
  //                           isCritical = value;
  //                         });
  //                       },
  //                     ),
  //                   ],
  //                 ),
  //                 TextFormField(
  //                   decoration: InputDecoration(labelText: 'Additional Note to Potential Donors'),
  //                   controller: additionalNoteController,
  //                   maxLines: 3,
  //                 ),
  //                 FormField<bool>(
  //                     builder: (state){
  //                       return Column(
  //                         children: <Widget>[
  //                           Row(
  //                             children: <Widget>[
  //                               Checkbox(
  //                                 value: agreedToTerms,
  //                                 onChanged: (value) {
  //                                   setState(() {
  //                                     agreedToTerms = value!;
  //                                   });
  //                                 }),
  //                               const Text('I have read and agree to these'),
  //                             ],
  //                           ),
  //                           //display error in matching theme
  //                           Text(
  //                             state.errorText ?? '',
  //                             style: TextStyle(
  //                               color: Theme.of(context).colorScheme.error
  //                             ),
  //                           )
  //                         ],
  //                       );
  //                     },
  //                   //output from validation will be displayed in state.errorText (above)
  //                   validator:(value){
  //                       if (!agreedToTerms) {
  //                         return 'You need to accept terms';
  //                       }
  //                     }
  //                 ),
  //                 Center(
  //                   child: ElevatedButton(
  //                     style: ElevatedButton.styleFrom(
  //                         // shape: CircleBorder(),
  //                       backgroundColor: Colors.red,
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(30.0), // Adjust the radius as needed
  //                       ),
  //                     ),
  //                     onPressed: () {
  //                       final form = _form2key.currentState;
  //                       if(form!.validate()){
  //                         // _requestData(
  //                         //     selectedBloodType ,
  //                         //   firstNameController.text,
  //                         //   mobileNumberController.text,
  //                         //   selectedBloodGroup,
  //                         //   DateController.text,
  //                         //   unitController.text,
  //                         //   locationController.text,
  //                         //   isCritical,
  //                         // );
  //                         AwesomeDialog(
  //                             context: context,
  //                             dialogType: DialogType.success,
  //                             animType: AnimType.bottomSlide,
  //                             showCloseIcon: true,
  //                             title: 'Requested',
  //                             desc: 'Your Request has sent Successfully...',
  //                             btnOkOnPress: () {
  //                                    // Action to be performed when OK button is pressed
  //                             },
  //                        )..show();
  //                         Navigator.push(
  //                           context,
  //                           MaterialPageRoute(builder: (context) => HomeScreen()),
  //                         );
  //                       }
  //
  //                       // Access the entered values using controllers or state variables
  //                     },
  //                     child: Container(
  //                       width: 200, // Set width as desired
  //                       height: 50,
  //                       alignment: Alignment.center,
  //                     child: Text('Send Request',style: TextStyle(fontSize: 18, color:Colors.white),),
  //                   ),
  //                 ),
  //                 )
  //               ],
  //             ),
  //           ),
  //           )
  //   );
  //   }


  void _showRequestDialog() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      showCloseIcon: true,
      title: 'Request for $selectedBloodGroup',
      desc: 'Your Request has been Submitted Successfully!',
      btnOkOnPress: () {
      },
    )
      ..show().then((value) {
        // Navigate to the home screen after dialog is dismissed
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(name: '', email: '', phone: '', gender: '', bgroup: '', dob: null, place: '',)),
        );
      });
  }
}

Future<void> _requestData(
    String selectedBloodType,
    String firstName,
    String phoneNumber,
    String selectedBloodGroup,
    String date,
    String units,
    String hospital,
    String location ,
    bool isCritical) async {
  var id = M.ObjectId();
  final requestdata = MongoDbModelRequest(
      id: id,
      bloodType: selectedBloodType,
      firstName: firstName,
      phoneNumber: phoneNumber,
      bloodGroup: selectedBloodGroup,
      date: date,
      unit: units,
      hospital: hospital,
      location: location,
      isCritical: isCritical,
  );
  var result = await MongoDatabase.request(requestdata);
}
