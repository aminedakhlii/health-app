import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFuncs {
  final User ? _currentUser = FirebaseAuth.instance.currentUser;
  
  search(String query) async {
    var _db = FirebaseFirestore.instance;

    await _db.collection('queries').add(
          {
            'user': _currentUser!.uid,
            'query': query,
            'date': DateTime.now().toString()
          });
  }
}