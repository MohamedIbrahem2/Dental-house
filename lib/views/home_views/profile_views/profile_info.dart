import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_house/provider/event_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:provider/provider.dart';
class profile_info extends StatefulWidget {

  @override
  State<profile_info> createState() => _profile_infoState();
}

class _profile_infoState extends State<profile_info> {
  bool check = false;
  bool check1 = false;
  bool edit = false;
  TextEditingController first = TextEditingController();
  TextEditingController last = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController date = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  CollectionReference users = FirebaseFirestore.instance.collection('Dental House');
  Future<void> addUser() {
    return users
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('info')
        .doc('info').update({
      'first_name': first.text,
      'last_name': last.text,// John Doe
      'Email': email.text, // Stokes and Sons
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: null,
        body:
        FutureBuilder<DocumentSnapshot>(
          future: users
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('info')
              .doc('info').get(),
          builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot> snapshot) {
            final provider = Provider.of<EventProvider>(context);
            if(snapshot.connectionState == ConnectionState.done){
              Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
              email.text = data['Email'];
              first.text = data['first_name'];
              last.text = data['last_name'];
              provider.lastName = data['last_name'];
            return Form(
              key: formState,
              child: SafeArea(
                child: Column(
                  children: [
                    ListTile(
                        leading: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new, color: Colors.black,
                              size: 20,)),

                        title: const Text("Account Info", style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),),
                        trailing: edit == false ? TextButton(
                            onPressed: () {
                              setState(() {
                                edit = true;
                              });
                            },
                            child: const Text("Edit",
                              style: TextStyle(color: Colors.blueAccent,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),))
                            : IconButton(
                            onPressed: () {
                              if(formState.currentState!.validate()){
                                setState(() {
                                  addUser();
                                  edit = false;
                                });
                              }
                            },
                            icon: Icon(Icons.check,
                              color: Colors.blueAccent,))
                    ),
                     profileData(
                        txt: "Email", ctrl: null, init: data['Email'], enable: false),
                    edit == true ? profileData(
                        txt: "First Name", ctrl: first, init: null, enable: true,Funcation: (val){
                      if(val!.length> 100){
                        return "name can't be more than 100 latter";
                      }
                      if(val.length < 2){
                        return "name can't be less than 2 latter";
                      }
                      return null;
                    },) :
                    profileData(txt: "First Name",
                        ctrl: null,
                        init: data['first_name'], enable: false,),
                    edit == true ? profileData(
                        txt: "Last Name", ctrl: last, init: null, enable: true,Funcation: (val){
                      if(val!.length> 100){
                        return "name can't be more than 100 latter";
                      }
                      if(val.length < 2){
                        return "name can't be less than 2 latter";
                      }
                      return null;
                    },) :
                    profileData(txt: "Last Name",
                        ctrl: null,
                        init: data['last_name'], enable: false),
                    profileData(
                        txt: "Date Of Birth (Optional)", ctrl: date, init: null, enable: true),
                    cirButton(name: "Male", name1: "Female"),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        color: Colors.blueAccent,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: ListTile(
                          title: Center(
                              child: Text("Delete Account", style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),)),
                          onTap: () {},
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            );
            } else {
              return Center(child: CircularProgressIndicator(),);
            }
          }
        ),
    );
  }
  Widget profileData({
    required String txt,
    required var ctrl,
    required var init,
    required bool enable,
    String? Funcation(String)?,

})=> Expanded(
  child:   Padding(

    padding: const EdgeInsets.all(10.0),

    child:   buildHeader(

        header: txt,

        child: TextFormField(

        keyboardType: TextInputType.name,
        validator: Funcation,

        enabled: enable,
        controller: ctrl,

        initialValue: init,
        decoration: InputDecoration(

          filled: edit == false ? true : false,

        fillColor: Colors.grey.shade200,

        enabledBorder: OutlineInputBorder(

        borderSide: BorderSide(color: Colors.blueAccent)

        ),

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),

        ),

        ),

      ),

  ),
);
  Widget buildHeader({
    required String header,
    required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(header,style: TextStyle(fontWeight: FontWeight.bold,color: edit == false ? Colors.grey : Colors.black),),
          child,
        ],
      );
  Widget cirButton({
    required String name,
    required String name1,
}) => Padding(
  padding: const EdgeInsets.all(10.0),
  child: buildHeader(
      header: "Gender (Optional)",
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(value: check,
    onChanged: (bool? value) {
      setState(() {
          check = value!;
          if(value == true){
            check1 = false;
          }
      });
    },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
            side: BorderSide(color: edit == false ? Colors.grey : Colors.black),
          ),
          Text(name,style: TextStyle(fontWeight: FontWeight.bold,color: edit == false ? Colors.grey : Colors.black),),
          Checkbox(value: check1,
            onChanged: (bool? value) {
              setState(() {
                check1 = value!;
                if(value == true){
                  check = false;
                }
              });
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
            side: BorderSide(color: edit == false ? Colors.grey : Colors.black),
          ),
          Text(name1,style: TextStyle(fontWeight: FontWeight.bold,color: edit == false ? Colors.grey : Colors.black),)
        ],
      ),
    ),
);

}
