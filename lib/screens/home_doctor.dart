import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';
import 'package:health/constants.dart';
import 'package:health/firebase/funcs.dart';
import 'package:health/models/patient.dart';
import 'package:health/screens/patient_data.dart';
import 'package:health/widgets/textField.dart';

class MyHomeDoc extends StatefulWidget {
  const MyHomeDoc({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomeDoc> createState() => _MyHomeDocState();
}

class _MyHomeDocState extends State<MyHomeDoc> {
  List<Patient> patients = [
    Patient(id: '1', name: 'Steve Jobs', picture: 'https://cdn.britannica.com/04/171104-050-AEFE3141/Steve-Jobs-iPhone-2010.jpg'),
    Patient(id: '2', name: 'Bill Gates', picture: 'https://media.wired.com/photos/5e6c06e613205e0008da2461/1:1/w_1600,h_1600,c_limit/Biz-billgates-950211062.jpg'),
    Patient(id: '3', name: 'Elon Musk', picture: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZt-Z2a-lrp7cokYL0K7VuIpJR5AbF7iR_XA&usqp=CAU'),
    Patient(id: '4', name: 'Lionel Messi', picture: 'https://img.a.transfermarkt.technology/portrait/big/28003-1631171950.jpg?lm=1'),
    Patient(id: '5', name: 'Kim Kardashian', picture: 'https://s.yimg.com/ny/api/res/1.2/hez7eif4X4U8HGL.WDIPmw--/YXBwaWQ9aGlnaGxhbmRlcjt3PTY0MDtoPTQ4MA--/https://media.zenfs.com/en/sheknows_79/b63c372c036d87c5cd5b9607de77587a')
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
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('My patients', style: cardTitleText.copyWith(color: Colors.black, fontSize: 30),),
            SizedBox(height: 30,),
            Expanded(
              child: ListView(
                children: [
                  for (var p in patients)
                    patientcard(p)
                  
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  patientcard(Patient p) {
    return InkWell(
      onTap: () => Get.to(() => PatientData(title: 'Patient data', patient: p,)),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(backgroundImage: NetworkImage(p.picture!), radius: 40,), 
                  SizedBox(width: 50,),
                  Text(p.name!, style: cardTitleText.copyWith(color: Colors.black),),
                ],
              ), 
            ],
          ),
        ),
      ),
    );
  }
}