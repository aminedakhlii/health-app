import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:health/firebase/funcs.dart';
import 'package:health/widgets/textField.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StringWrapper query = StringWrapper(); 
  FirebaseFuncs funcs = FirebaseFuncs();

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: MyTextField(
              hintText: 'Query...',
              inputType: TextInputType.text,
              onChanged: query,
            ),
          ),
          FloatingActionButton.extended(
            onPressed: () async {
              await funcs.search(query.value!);
              
            },
            label: Text('Search'),
          )
        ],
      ),
    );
  }
}