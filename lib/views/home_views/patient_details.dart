
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_house/models/pData.dart';
import 'package:dental_house/provider/event_provider.dart';
import 'package:dental_house/views/Patients_Info_views/dental_notes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../Patients_Info_views/dental_chart.dart';
class PatientDetails extends StatefulWidget {
  final MyData myList;
   const PatientDetails({Key? key,
    required this.myList,
  }) : super(key: key);

  @override
  State<PatientDetails> createState() => _PatientDetailsState();
}

class _PatientDetailsState extends State<PatientDetails> {
  List<String> teeth = [];
  CollectionReference users = FirebaseFirestore.instance.collection('Dental House');

  Future<void> addUser() {
    return users
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('patients')
        .doc(widget.myList.id)
        .collection('dentalNotes')
        .get()
        .then((QuerySnapshot qs){
      qs.docs.forEach((doc){
        teeth.add(doc['toothNumber']);
      });
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      final provider = Provider.of<EventProvider>(context, listen: false);
      await addUser();
      provider.addPro1(teeth);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
        backgroundColor: Colors.blueAccent,
        title: Text("Patient Information",style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(onPressed: (){
          }, icon: Icon(Icons.delete,color: Colors.white,)),
          IconButton(onPressed: (){
          }, icon: Icon(Icons.edit,color: Colors.white,))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClipOval(
                  child: SvgPicture.asset("images/contacts.svg",
                    width: 100,
                    height: 100,
                  ),
                ),
                Text(widget.myList.fName + " " +  widget.myList.lName,style: TextStyle(color: Colors.white),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.white,
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(onPressed: (){
                    }, icon: Icon(Icons.call,color: Colors.blueAccent,)),
                    IconButton(onPressed: (){
                    }, icon: Icon(Icons.sms,color: Colors.blueAccent,)),
                    IconButton(onPressed: (){
                    }, icon: Icon(Icons.smart_screen,color: Colors.blueAccent,))
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Card(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("First Name",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                      Text(widget.myList.fName,style: TextStyle(color: Colors.black),),
                      Text("Last Name",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                      Text(widget.myList.lName,style: TextStyle(color: Colors.black),),
                      Text("Phone Number",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                      Text(widget.myList.phone,style: TextStyle(color: Colors.black),),
                      Text("Age",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                      Text(widget.myList.age,style: TextStyle(color: Colors.black),),
                      crd(txt1: 'Dental Chart', txt2: "Edit Patient's Chart",onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> DentalChart(myList: widget.myList,)));
                      }),
                      crd(txt1: 'Dental Notes', txt2: 'Review Notes',onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> DentalNotes(myList: widget.myList,)));
                      }),
                      crd(txt1: 'Patient Photo', txt2: "Patient's Dental Photo")
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget crd ({
    required String txt1,
    required String txt2,
    var onTap,
})=> InkWell(
    onTap: onTap,
  child: Card(
      color: Colors.white,
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Icon(Icons.call,color: Colors.blueAccent,),
            Column(
              children: [
                Row(
                  children: [
                    Text(txt1,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                    SizedBox(width: 5,),
                    Container(
                      width: 20,
                      height: 20,
                      color: Colors.blueAccent,
                      child: Center(child: Text("0",style: TextStyle(color: Colors.white),)),
                    )
                  ],
                ),
                Text(txt2,style: TextStyle(color: Colors.black),),
              ],
            ),
             Icon(Icons.arrow_forward_ios,color: Colors.blueAccent,),
          ],
        ),
      ),
    ),
);
}
