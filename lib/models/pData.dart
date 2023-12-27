import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<MyData>> fetchData() async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('patients').get();

  List<MyData> dataList = [];

  for (var doc in querySnapshot.docs) {
    dataList.add(MyData(
      name: doc.get("name"),
      age: doc.get("age"),
      email: doc.get("Email"),
      phone: doc.get("PhoneNum"),
      id: doc.get('id'),
    ));
  }

  return dataList;
}
Future<void> deleteData(String documentId) async {
  final CollectionReference dataCollection =
  FirebaseFirestore.instance.collection('patients');
  await dataCollection.doc(documentId).delete();
}
class MyData {
  final String name;
  final String age;
  final String email;
  final String phone;
  final String id;

  MyData({required this.name, required this.age,required this.email, required this.phone, required this.id});
}