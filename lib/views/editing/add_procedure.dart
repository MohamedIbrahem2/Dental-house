import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_house/provider/event_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dental_house/views/home_views/procedure.dart';
import 'package:provider/provider.dart';

class AddProcedure extends StatefulWidget {
  const AddProcedure({Key? key}) : super(key: key);

  @override
  State<AddProcedure> createState() => _AddProcedureState();
}

class _AddProcedureState extends State<AddProcedure> {
  var currentFocus;
  unFocus() {
    currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
  CollectionReference users = FirebaseFirestore.instance.collection('Dental House');
  Future<void> addProcedure() {
    return users
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Procedure')
        .add({
      'procedure': proName.text,
      'amount': amount.text,
    })
        .then((value) => print("Procedure Added"))
        .catchError((error) => print("Failed to add procedure: $error"));
  }

  TextEditingController proName = TextEditingController();
  TextEditingController amount = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<EventProvider>(
        builder: (BuildContext context, EventProvider model, Widget? child) {
      return GestureDetector(
        onTap: unFocus,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueAccent,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            title: const Text(
              "Add Procedure",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: proName,
                    validator: (val) {
                      if (val!.length > 100) {
                        return "Procedure Can't Be More Than 100 Word";
                      }
                      if (val.length < 3) {
                        return "Procedure Can't Be Less Than 3 word";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: "Enter Procedure Name",
                        labelText: "Name",
                        labelStyle: TextStyle(color: Colors.blueAccent)),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent, elevation: 5),
                          onPressed: () async{
                            if(_formKey.currentState!.validate()){
                              await addProcedure();
                              model.addPro();
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            'Confirm',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
