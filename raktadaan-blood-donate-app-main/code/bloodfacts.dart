import 'package:bb_ui/textSection.dart';
import 'package:flutter/material.dart';
class BloodFacts extends StatefulWidget {
  const BloodFacts({super.key});

  @override
  State<BloodFacts> createState() => _BloodFactsState();
}

class _BloodFactsState extends State<BloodFacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BloodFacts'), backgroundColor: Colors.red,
      ),
      body:SingleChildScrollView(
      child: Column(
      children:[
        Image.asset(
          'assets/blood_type_compatibility_chart.jpg',
          fit : BoxFit.cover,
        ),
      TextSection("Who is called as Universal Donor?","The Universal Donor refers to individuals with type O-negative blood. "
          "Type O-negative blood is considered universal because it can be transfused to people of any blood type (A, B, AB, or O) without causing adverse reactions. "
          "This blood type is often in high demand during emergencies when the recipient's blood type is unknown or when there is limited time for blood typing and cross-matching."),
      TextSection("Who is called as Universal Acceptor?",
          "The Universal Acceptor refers to individuals with type AB-positive blood. "
              "People with type AB-positive blood are often called universal recipients because they can receive blood from donors of any blood type (A, B, AB, or O) without having adverse reactions. "
              "This blood type is known for its ability to accept transfusions from all other blood types."),
        TextSection('What is "Bombay blood group"?', 'The Bombay blood group is an extremely rare blood type that was first discovered in Bombay (now Mumbai), India.'
            ' Individuals with the Bombay blood group lack certain antigens that are present in most other blood types.'
            'The Bombay blood group is so rare that it occurs in about 1 in 250,000 individuals in the general population. '
            ' The individuals with this blood type can only receive blood from others with the same group.'),
        TextSection('What is A1 blood group?', 'The A1 blood group specifically refers to the most common subtype within the A blood type category. '
            'There are two major subtypes of blood type A: A1 and A2. '
            'A1 is more prevalent and is usually the default blood type referred to when someone has blood type A unless further subtyping is necessary for specific medical reasons.'),
        TextSection('How much is the "Shelf Life" of Blood?', 'Generally, whole blood can be stored for up to 35 to 42 days, depending on the anticoagulant used and storage conditions. '
            'After this period, it may start to degrade and lose its efficacy.'),
      ]
    )
      )
    );

  }

}