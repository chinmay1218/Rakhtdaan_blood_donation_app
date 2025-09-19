import 'package:bb_ui/blood_donate.dart';
import 'package:bb_ui/bloodsearch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'bloodfacts.dart';
import 'bloodrequest.dart';
import 'filter_blood.dart';
import 'package:intl/intl.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen( {super.key,  required this.name, required this.email, required this.phone, required this.gender, required this.bgroup, required this.dob, required this.place});
  final String name;
  final String email;
  final String phone;
  final String gender;
  final String bgroup;
  final DateTime? dob;
  final String place;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<IconData> _icons = [
    Icons.home,
    Icons.person,
    Icons.history_rounded
  ];
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    ProfilePage(),
    HistoryPage(),
  ];
  //function to change the state if icon
  List<bool> _selected = List.generate(4, (index) => false);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Toggle the selected state for the clicked icon
      for (int i = 0; i < _selected.length; i++) {
        _selected[i] = (i == index);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Row(
            children :[
              Text("Welcome to Raktdaan"),
            ]
          ),
          automaticallyImplyLeading: false, // Remove default back arrow
          backgroundColor: Colors.red,
          foregroundColor:Colors.white,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, color: Colors.redAccent),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline ,color: Colors.redAccent),
            label: 'Donor Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined,color: Colors.redAccent ),
            label: 'History',
          ),
        ],
      ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: (){},
              tooltip: 'Search',
              backgroundColor: Colors.redAccent,
              child: const Icon(Icons.chat),
            )
          ],
        )
    );
  }

  Widget homePage() {
    return const Center(
        child: Text("This is home page")
    );
  }
}

class HistoryPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("History Page"),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      // Access name and email from HomeScreen using context
      final HomeScreen? homeScreen = context.findAncestorWidgetOfExactType<HomeScreen>();
      final String name = homeScreen?.name ?? ''; // Using null-aware operator
      final String email = homeScreen?.email ?? ''; // Using null-aware operator
      final String phone = homeScreen?.phone ?? '';
      final String gender = homeScreen?.gender ?? '';
      final String bgroup = homeScreen?.bgroup ?? '';
      final Object dob = homeScreen?.dob ?? '';
      final String place = homeScreen?.place ?? '';
  return SafeArea(
    child: Card(
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.red,
            radius: 60,
            child: Text(
                bgroup,
              style: TextStyle(color: Colors.white, fontSize: 48),
            ),
          ),
          Row(
      children: [
          if (gender == 'male')
          Center(
             child: const Icon(
              Icons.male,
               size: 50,
            ),
        )
       else if (gender == 'female' || gender == 'others')
           Center(
             child: const Icon(
              Icons.female,
               size: 50,
            ),
         ),
        Center(
          child: Text(
              name,
            style: TextStyle(fontSize: 18),
          ),
         ),
        ]
    ),
          Table(
            border: TableBorder.all(),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const <int, TableColumnWidth>{
                0: IntrinsicColumnWidth(),
                1: FlexColumnWidth(),
              },
            children: [
                TableRow(
                   decoration: BoxDecoration(
                   color: Colors.grey[200],
                 ),
                children: [
                   TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Name:'),
                      ),
                    ),
                  TableCell(
                    child: Center(

                      child: Text(name)),
                  ),
                ],
              ),
              TableRow(
                 children: [
                    TableCell(
                    child:  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Email:'),
                    ),
                    ),
                  TableCell(
                  child: Center(child: Text(email)),
                  ),
                ],
              ),
              TableRow(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                ),
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Gender:'),
                    ),
                  ),
                  TableCell(
                    child: Center(child: Text(gender)),
                  ),
                ],
              ),
              TableRow(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                ),
                children: [
                  TableCell(
                    child:  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Blood Group'),
                    ),
                  ),
                  TableCell(
                    child: Center(child: Text(bgroup)),
                  ),
                ],
              ),
              TableRow(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                ),
                children: [
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Date of Birth:\n(yyyy-MM-dd)'),
                    ),
                  ),
                  TableCell(
                    child: Center(child: Text(
                      dob != null && dob is DateTime
                        ? DateFormat('yyyy-MM-dd').format(dob as DateTime) // Format DateTime to display only the date
                        : 'No date of birth',)),
                  ),
                ],
              ), TableRow(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                ),
                children: [
                  TableCell(
                    child:  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Location'),
                    ),
                  ),
                  TableCell(
                    child: Center(child: Text(place)),
                  ),
                ],
              ),
              ]
          ),
        ]
      ),
    ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            children: [
              BloodTile(
                title: 'Donate Blood',
                icon: 'assets/blooddonate_2.png' ,
                color: Colors.redAccent,
                onPressed: () {
                  // navigate to donate page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Donate()),
                  );
                  print('Blood Donate');
                },
              ),
              BloodTile(
                title: 'Request for Blood',
                icon: 'assets/bloodrequest.png',
                color: Colors.redAccent,
                onPressed: () {
                  // navigate to request page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BloodRequest()),
                  );
                  print('Request for Blood');
                },
              ),
              BloodTile(
                title: 'Blood Search',
                icon: 'assets/bloodsearch.png' ,
                color: Colors.redAccent,
                onPressed: () {
                  // navigate to donate page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Survey()),
                  );
                  // print('Blood Search');
                },
              ),
              BloodTile(
                title: 'Blood Facts',
                icon: 'assets/bloodanalysis.png',
                color: Colors.redAccent,
                onPressed: () {
                  // navigate to donate page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BloodFacts()),
                  );
                  // print('Doante History');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
class BloodTile extends StatelessWidget {
  final String title;
  final String icon;
  final Color color;
  final VoidCallback? onPressed;

  const BloodTile({
    required this.title,
    required this.icon,
    required this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        color: Colors.redAccent,
        elevation: 8,
        margin: const EdgeInsets.all(14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
                icon,
                height: 50,
                width: 50,
              ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// // Placeholder Pages for each section
// class BloodSearchPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'Blood Search Page',
//         style: TextStyle(fontSize: 24.0),
//       ),
//     );
//   }
// }
//
// class BloodDonatePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'Blood Donate Page',
//         style: TextStyle(fontSize: 24.0),
//       ),
//     );
//   }
// }
//
// class BloodFactsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'Blood Facts Page',
//         style: TextStyle(fontSize: 24.0),
//       ),
//     );
//   }
// }
//



