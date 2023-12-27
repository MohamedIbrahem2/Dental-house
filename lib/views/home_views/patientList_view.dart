import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/pData.dart';
class PatientList extends StatefulWidget {
  const PatientList({Key? key}) : super(key: key);

  @override
  State<PatientList> createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: null,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('patients').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child:CircularProgressIndicator(color: Colors.white,));
          }
          List<DocumentSnapshot> documents = snapshot.data!.docs;
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
                                  final String item = data['name'];
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

                                              },
                                              trailing: IconButton(onPressed: () async{
                                                await deleteData(data['id']);
                                              }, icon: const Icon(Icons.delete,color: Colors.blueAccent,)),
                                              leading: const Icon(Icons.person_outline,color: Colors.blueAccent,),
                                                title: Text(data['name']),
                                                  subtitle: Text(data['Email']),
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
    )
    );
  }
  }