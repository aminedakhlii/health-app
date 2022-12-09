import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:health/constants.dart';
import 'package:health/firebase/funcs.dart';
import 'package:health/models/patient.dart';
import 'package:health/widgets/textField.dart';

class PatientData extends StatefulWidget {
  const PatientData({Key? key, required this.patient, required this.title}) : super(key: key);

  final String title;
  final Patient patient;

  @override
  State<PatientData> createState() => _PatientDataState();
}

class _PatientDataState extends State<PatientData> {
  List<String> searchHistoryFake = [
    'Vitamin D sup : Oct 5th 2011 at 1am',
    'Parkizol : Oct 3rd 2011 at 2pm',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
         IconButton(
           icon: const Icon(Icons.person),
           onPressed: () {
             Navigator.push(
               context,
               MaterialPageRoute<ProfileScreen>(
                 builder: (context) => const ProfileScreen(),
               ),
             );
           },
         )
       ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(backgroundImage: NetworkImage(widget.patient.picture!), radius: 40,), 
                SizedBox(width: 20,),
                Column(
                  children: [
                    Text(widget.patient.name!, style: cardTitleText.copyWith(color: Colors.black, fontSize: 35),),
                    Text('Current status : Dead', style: cardTitleText.copyWith(color: Colors.grey, fontSize: 20),),
                  ],
                ),
              ],
            ), 
            SizedBox(height: 30,),
            Text('Drug intake history', style: cardTitleText.copyWith(color: Colors.blue, fontSize: 35),),
            SizedBox(height: 30,),
            Expanded(
              child: ListView(
                children: [
                  for (var item in searchHistoryFake)
                    Text(item, style: cardBodyText.copyWith(color: Colors.black, fontSize: 20),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}