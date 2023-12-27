import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_house/provider/event_provider.dart';
import 'package:dental_house/views/home_views/patientList_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
class NewPatient extends StatefulWidget {
  const NewPatient({Key? key}) : super(key: key);

  @override
  State<NewPatient> createState() => _NewPatientState();
}

class _NewPatientState extends State<NewPatient> {
  final _formKey = GlobalKey<FormState>();
  var name , age, email, phone;
  var uuid = const Uuid();
  late String id = uuid.v4();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('patients');
  Future<void> addUser() {
    return users
        .doc(id).set({
      'name': nameController.text,
      'age': ageController.text,
      'Email': emailController.text,
      'PhoneNum': phoneController.text,
      'id' : id,
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<EventProvider>(builder: (context,model,child){
      return Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: null,
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Center(
                      child: Text(
                        'Patient Information',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: const Center(
                    child: Text(
                      'Fill below details to add patient',
                      style: TextStyle(fontSize: 15,color: Colors.white),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: SizedBox(
                    height: double.infinity,
                    width: double.infinity,
                    child: Card(
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
                      elevation: 4.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            txtField(onSaved: (val){
                              name = val;
                            },
                              ctrl: nameController,
                              txt1: "Name can't to be longer than 100 letter",
                              txt2: "Name can't to be less than 2 letter",
                              num: 2,
                              txtInput: TextInputType.name,
                              hntTxt: "Type Name", labText: "Name",
                              num2: 100,),
                            txtField(onSaved: (val){
                              age = val;
                            }, ctrl: ageController, txt1: "age can't to be longer than 2 number",
                                txt2: "age can't to be less than 1 number",
                                num2: 2,
                                num: 1, txtInput: TextInputType.number, hntTxt: "Type Age",
                                labText: "Age"),
                            txtField(onSaved: (val){
                              email = val;
                            }, ctrl: emailController, txt1: "Email can't to be longer than 100 letter",
                                txt2: "email can't to be less than 4 letter",
                                num2: 100,
                                num: 4, txtInput: TextInputType.emailAddress, hntTxt: "Type Email",
                                labText: "Email"),
                            txtField(onSaved: (val){
                              phone = val;
                            }, ctrl: phoneController, txt1: "phone can't to be longer than 100 number",
                                txt2: "number can't to be less than 11 number",
                                num2: 100,
                                num: 11, txtInput: TextInputType.phone, hntTxt: "Type phone number",
                                labText: "phone"),
                            ElevatedButton(
                              onPressed: () async{
                                if (_formKey.currentState!.validate()) {
                                  await addUser();
                                  model.changePage(1);
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Patient add successfully"),
                                  elevation: 10,
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),side: BorderSide(color: Colors.white,width: 3)),
                                    margin: EdgeInsets.all(15),
                                  ));
                                  setState(() {
                                  });
                                }
                              },
                              child: Text('Add Patient'),
                            ),
                          ],
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
  Widget txtField({
    required void Function(String?)? onSaved,
    required TextEditingController ctrl,
    required String txt1,
    required String txt2,
    required int num,
    required TextInputType? txtInput,
    required String hntTxt,
    required String labText,
    required int num2,
  }) => Padding(
    padding: const EdgeInsets.all(12.0),
    child: TextFormField(
      onSaved: onSaved,
      controller: ctrl,
      validator: (val){
        if(val!.length> num2){
          return txt1;
        }
        if(val.length < num){
          return txt2;
        }
        return null;
      },
      keyboardType: txtInput,
      decoration: InputDecoration(
        hintText: hntTxt,
        labelText: labText,
      ),
    ),
  );
}
