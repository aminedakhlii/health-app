import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:health/auth_gate.dart';
import 'package:health/widgets/textField.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Health app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthGate(),
    );
  }
}
