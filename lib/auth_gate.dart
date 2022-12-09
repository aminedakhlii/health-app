import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:health/screens/home_doctor.dart';
import 'package:health/screens/home_patient.dart';

class AuthGate extends StatelessWidget {
 const AuthGate();

 @override
 Widget build(BuildContext context) {
   return StreamBuilder<User?>(
     stream: FirebaseAuth.instance.authStateChanges(),
     builder: (context, snapshot) {
       if (!snapshot.hasData) {
         return const SignInScreen(
           providerConfigs: [
            EmailProviderConfiguration(),
            GoogleProviderConfiguration(clientId: '')
           ],
         );
       }

       return const MyHomePage(title: 'Health app',);
     },
   );
 }
}