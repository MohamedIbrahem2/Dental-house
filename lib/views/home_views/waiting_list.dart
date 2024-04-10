import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_house/models/pData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class WaitingList extends StatefulWidget {
  const WaitingList({Key? key}) : super(key: key);



  @override
  State<WaitingList> createState() => _WaitingListState();

}
Future<void> deletePatient(String documentId) async {
  final CollectionReference dataCollection =
  FirebaseFirestore.instance.collection('Dental House');
  await dataCollection
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('waitingList')
      .doc(documentId).delete();
}
class _WaitingListState extends State<WaitingList> {
  bool show = false;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Dental House')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('waitingList')
              .snapshots(),
          builder: (context,snapshot) {
            if(snapshot.hasData){
              final documents = snapshot.data!.docs;
              return Scaffold(
                appBar: AppBar(
                leading: IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: Icon(Icons.arrow_back)),
                backgroundColor: Colors.blueAccent,
                title: Text("Waiting List"),
              ),
                body: show == documents.isEmpty ?
                SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topLeft: Radius
                              .circular(20), topRight: Radius.circular(
                              20))),
                      elevation: 4.0,
                      child: ListView.builder(
                        itemCount: documents.length,
                          itemBuilder: (context, index) {
                            var data = documents[index].data() as Map<String, dynamic>;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),side: BorderSide(width: 3,color: Colors.blueAccent)),
                                elevation: 3,
                                child: ListTile(
                                  onTap: (){
                                  },
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(onPressed: (){
                                        setState(() {
                                          deletePatient(data['id']);
                                        });
                                      }, icon: const Icon(Icons.delete,color: Colors.blueAccent,))
                                    ],
                                  ),
                                  title: Row(
                                    children: [
                                      Text(data['firstName']),
                                      Text(data['lastName'])
                                    ],
                                  ),
                                  leading: const Icon(Icons.person_outline,color: Colors.blueAccent,),
                                ),
                              ),
                            );
                          }
                      )
                  ),
                ):
                Center(child: Text("No Patients in waiting list",style: TextStyle(color: Colors.black,fontSize: 18),))
              );
            }
            if (!snapshot.hasData) {
              return const Center(child:CircularProgressIndicator(color: Colors.white,backgroundColor: Colors.blueAccent,));
            }
            return Expanded(
              child: Text("No Patients in waiting list",style: TextStyle(color: Colors.black,fontSize: 18),),
            );
          }
      );

  }
}
