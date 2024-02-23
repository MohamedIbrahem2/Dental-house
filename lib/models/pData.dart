import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> deleteData(String documentId) async {
  final CollectionReference dataCollection =
  FirebaseFirestore.instance.collection('Dental House');
  await dataCollection
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('patients')
      .doc(documentId).delete();
}

class MyData {
  final String fName;
  final String age;
  final String lName;
  final String phone;
  final String id;

  MyData({required this.fName, required this.age,required this.lName, required this.phone, required this.id});
}