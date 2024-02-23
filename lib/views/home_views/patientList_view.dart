import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_house/provider/event_provider.dart';
import 'package:dental_house/views/home_views/patient_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/pData.dart';
class PatientList extends StatefulWidget {
  const PatientList({Key? key}) : super(key: key);

  @override
  State<PatientList> createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  bool isDark = false;
  late MyData list;
  var currentFocus;

  unFocus() {
    currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context).lists;
    final myList = Provider.of<EventProvider>(context);
    return GestureDetector(
      onTap: unFocus,
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: null,
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Dental House')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('patients')
              .snapshots(),
          builder: (context,snapshot) {
            if(snapshot.hasData){
            final documents = snapshot.data!.docs;
            provider.clear();
            for(var e in documents){
              final fName = e.get("firstName");
              final lName = e.get("lastName");
              final age = e.get("age");
              final phone = e.get("PhoneNum");
              final id = e.get("id");

              list = MyData(fName: fName,
                  age: age,
                  lName: lName,
                  phone: phone,
                  id: id);
              provider.add(list);
            }
                  return SafeArea(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Center(
                                child: Text(
                                  'Patient List',
                                  style: TextStyle(fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: SearchAnchor(
                                  builder: (BuildContext context, SearchController controller) {
                                    return SearchBar(
                                      controller: controller,
                                      padding: const MaterialStatePropertyAll<EdgeInsets>(
                                          EdgeInsets.symmetric(horizontal: 16.0)),
                                      onTap: () {
                                        controller.openView();
                                      },
                                      onChanged: (_) {
                                        controller.openView();
                                      },
                                      leading: const Icon(Icons.search),
                                    );
                                  }, suggestionsBuilder: (BuildContext context, SearchController controller) {
                                  return List<ListTile>.generate(documents.length, (int index) {
                                    var data = documents[index].data() as Map<String, dynamic>;
                                    final String item = data['firstName'] + data['lastName'];
                                    return ListTile(
                                      title: Text(item),
                                      onTap: () {
                                        setState(() {
                                          controller.closeView(item);
                                        });
                                      },
                                    );
                                  });
                                },
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: SizedBox(
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
                                                  MyData selectedItem = myList.getSelectedItem(index);
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PatientDetails(myList: selectedItem,)));
                                                },
                                                trailing: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    IconButton(onPressed: () {
                                                      deleteData(data['id']);
                                                    }, icon: const Icon(Icons.delete,color: Colors.blueAccent,))
                                                  ],
                                                ),
                                                leading: const Icon(Icons.person_outline,color: Colors.blueAccent,),
                                                  title: Row(
                                                    children: [
                                                      Text(data['firstName']),
                                                      Text(data['lastName'])
                                                    ],
                                                  ),
                                                    subtitle: Text(data['PhoneNum']),
                                                      ),
                                                              ),
                                                            );
                                          }
                                )
                              ),
                            ),
                          ),
                        ]
                    ),
                  );
            }
            if (!snapshot.hasData) {
              return const Center(child:CircularProgressIndicator(color: Colors.white,));
            }
            return Container();
          }
      )
      ),
    );
  }
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
  }