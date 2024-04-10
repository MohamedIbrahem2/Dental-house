import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../models/pData.dart';
import '../../provider/event_provider.dart';

class DentalNotes extends StatelessWidget {
  final MyData myList;

  const DentalNotes({
    Key? key,
    required this.myList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context, listen: false);
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Dental House')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('patients')
            .doc(myList.id)
            .collection('dentalNotes')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final notesDocument = snapshot.data!.docs;
            return Scaffold(
              backgroundColor: Colors.blueAccent,
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
                backgroundColor: Colors.blueAccent,
                title: const Text(
                  "Dental Notes",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ClipOval(
                          child: SvgPicture.asset(
                            "images/contacts.svg",
                            width: 100,
                            height: 100,
                          ),
                        ),
                        Text(
                          myList.fName + " " + myList.lName,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          elevation: 4.0,
                          child: ListView.builder(
                              itemCount: notesDocument.length,
                              itemBuilder: (BuildContext context, int index) {
                                var data = notesDocument[index].data()
                                    as Map<String, dynamic>;
                                String clr = data['color'];
                                if(clr == "Color(0xff000000)"){
                                  clr = clr.replaceAll("Color(", "");
                                  clr = clr.replaceAll(")", "");
                                }else if(clr == "ColorSwatch(primary value: Color(0xff9c27b0))"){
                                  clr = clr.replaceAll("ColorSwatch(primary value: ", "");
                                  clr = clr.replaceAll("Color(", "");
                                  clr = clr.replaceAll("))", "");
                                }
                                else{
                                  clr = clr.replaceAll(
                                      "MaterialColor(primary value: ", "");
                                  clr = clr.replaceAll("Color(", "");
                                  clr = clr.replaceAll("))", "");
                                }

                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Card(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),side: BorderSide(width: 3,color: Colors.blueAccent)),
                                        elevation: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            children: [
                                              ClipOval(
                                                  child: Container(
                                                width: 30,
                                                height: 30,
                                                color: Color(int.parse(clr)),
                                              )),
                                              SizedBox(
                                                width: 30,
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text("Tooth Number: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                                      Text( data['toothNumber'])
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text("Procedure: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                                                          Text(data['procedure'])
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text("Note Date: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                                                      Text(data['date'])
                                                    ],
                                                  ),
                                                  data['note'] != "" ? Row(
                                                    children: [
                                                      Text("Note : ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                                                      Text(data['note'])
                                                    ],
                                                  )
                                                  : Container(),

                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Card(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),side: BorderSide(width: 3,color: Colors.blueAccent)),
                                              elevation: 3,
                                              child: IconButton(onPressed: (){}, icon: Icon(Icons.edit))),
                                          Card(
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),side: BorderSide(width: 3,color: Colors.blueAccent)),
                                              elevation: 3,
                                              child: IconButton(onPressed: (){
                                                provider.toothClr.removeAt(index);
                                                provider.i--;
                                                provider.selectedTeethNote.removeAt(index);
                                                deleteNote(data['toothNumber'],myList.id);
                                              }, icon: Icon(Icons.delete))),
                                        ],
                                      )
                                    ],
                                  ),

                                );
                              })),
                    ),
                  )
                ],
              ),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return Center(
            child: Text("No Dental Notes Found"),
          );
        });
  }
}
