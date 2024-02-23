import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GeneralBodyPart {
  String name;
  String path;

  GeneralBodyPart({
    required this.name,
    required this.path,
  });
}
CollectionReference users = FirebaseFirestore.instance.collection('Dental House');
Future<void> addTeeth(String id,String num) {
  return users
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('patients')
      .doc(id)
      .collection('teeth clicked')
      .add({
    'teethNum': num,
  })
      .then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}
