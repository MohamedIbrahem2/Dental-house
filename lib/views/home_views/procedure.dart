import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_house/models/procedureModel.dart';
import 'package:dental_house/provider/event_provider.dart';
import 'package:dental_house/views/Patients_Info_views/add_dental_notes.dart';
import 'package:dental_house/views/editing/add_procedure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/pData.dart';

class Procedure extends StatefulWidget {
  final MyData myList;
  const Procedure({Key? key,
    required this.myList,
  }) : super(key: key);

  @override
  State<Procedure> createState() => _ProcedureState();
}

class _ProcedureState extends State<Procedure> {
  bool show = true;
  bool check = false;
  late MyProcedure list;


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    final pro = Provider.of<EventProvider>(context).procedure;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Dental House')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('Procedure')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            provider.documents = snapshot.data!.docs;
            pro.clear();
            for (var e in provider.documents) {
              final pName = e.get("procedure");
              list = MyProcedure(name: pName, val: false);
              pro.add(list);
            }
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.blueAccent,
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>AddDentalNotes(myList: widget.myList,)));
                      },
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.white,
                      )),
                  title: const Text(
                    "Procedure",
                    style: TextStyle(color: Colors.white),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (
                                      context) => const AddProcedure()));
                          provider.addPro();
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.white)),
                        child: Text("ADD +"))
                  ],
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    show == provider.procedure.isNotEmpty
                        ? Expanded(
                      child: SizedBox(
                        height: 100,
                        width: double.infinity,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: provider.documents.length,
                            itemBuilder: (BuildContext context, int index) {
                              var data = provider.documents[index].data() as Map<String, dynamic>;
                              return CheckboxListTile(
                                title: Text(data['procedure']),
                                value: provider.ischecked[index],
                                controlAffinity: ListTileControlAffinity.leading,
                                subtitle: Container(
                                  width: double.infinity,
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if(value == true){
                                      provider.lines.add(pro[index].name);
                                    }else{
                                      provider.lines.remove(pro[index].name);
                                    }
                                    provider.ischecked[index] = value!;
                                    pro[index] = MyProcedure(name: data['procedure'], val: value);
                                  });
                                },
                              );
                            }),
                      ),
                    )
                        : const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("No Procedure Found"),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                elevation: 5),
                            onPressed: () {
                              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>AddDentalNotes(myList: widget.myList,)));
                              provider.addPro();
                            },
                            child: Text(
                              'Close',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                elevation: 5),
                            onPressed: () {
                              provider.tileColor = Colors.yellow;
                              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>AddDentalNotes(myList: widget.myList,)));
                            },
                            child: Text(
                              'Confirm',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
            );
          }
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.white,));
          }
          return Text("No Procedure Found");
        }

    );
  }


  }

