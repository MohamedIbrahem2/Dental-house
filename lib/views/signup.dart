
import 'dart:ffi';

import 'package:dental_house/views/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dental_house/views/home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_dialog/awesome_dialog.dart';


class signup extends StatefulWidget {
  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  var firstName, lastName , myemail, password;
  bool secure = true;

  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController pass = TextEditingController();

  GlobalKey<FormState> formState = GlobalKey<FormState>();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> addUser() {
    return users
        .doc('info').set({
      'first_name': fName.text,
      'last_name': lName.text,
      'Email': email.text,
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }



  signUp() async {
    var formData = formState.currentState;
    if(formData!.validate()){
      formData.save();

      try {
              UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: myemail,
                  password: password
              );
              return userCredential;
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                AwesomeDialog(
                  borderSide: BorderSide(
                      width: 3,
                      color: Colors.blue
                  ),
                  context: context,
                  title: "Error",
                  body: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text("password is too weak",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  ),
                )..show();
                print('The password provided is too weak.');
              } else if(e.code == 'invalid-email'){
                AwesomeDialog(
                  borderSide: BorderSide(
                      width: 3,
                      color: Colors.blue
                  ),
                  context: context,
                  title: "Error",
                  body: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text("This is not email address type",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                  ),
                )..show();
              }
              else if (e.code == 'email-already-in-use') {
                AwesomeDialog(
                  borderSide: BorderSide(
                    width: 3,
                    color: Colors.blue
                  ),
                  context: context,
                  title: "Error",
                  body: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text("The account already exists for that email",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                  ),
                )..show();
                print('The account already exists for that email.');
              }
            } catch (e) {
              print(e);
            }
    }else{
      print("Not Valid");
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body:
      Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset("images/login-01.png", fit: BoxFit.fill,),
          ),
          Form(
            key: formState,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: IconButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        icon: Icon((Icons.arrow_back_ios),color: Colors.white,)
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text("Create \nAccount",style: TextStyle(
                        color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold
                    )),
                  ),
                  txtField(onSaved: (val){
                    firstName = val;
                  }, ctrl: fName, txt1: "First Name can't to be longer than 100 letter",
                      txt2: "First Name can't to be less than 2 letter",
                      num: 2, txtInput: TextInputType.name, hntTxt: "Type First Name", secure: false,
                      labText: "First name", pre: Icon(Icons.person_outline), suffix: null),
                  txtField(onSaved: (val){
                    lastName = val;
                  }, ctrl: lName, txt1: "Last Name can't to be longer than 100 letter",
                      txt2: "Last Name can't to be less than 2 letter",
                      num: 2, txtInput: TextInputType.name, hntTxt: "Type Last Name", secure: false,
                      labText: "Last name", pre: Icon(Icons.person_outline), suffix: null),
                  txtField(onSaved: (val){
                    myemail = val;
                  }, ctrl: email, txt1: "Email can't to be longer than 100 letter",
                      txt2: "Email can't to be less than 2 letter",
                      num: 2, txtInput: TextInputType.emailAddress, hntTxt: "Type Email", secure: false,
                      labText: "Email", pre: Icon(Icons.email_outlined), suffix: null),
                  txtField(onSaved: (val){
                    password = val;
                  }, ctrl: pass, txt1: "password can't to be longer than 100 letter",
                      txt2: "password can't to be less than 4 letter",
                      num: 4, txtInput: TextInputType.visiblePassword, hntTxt: "Type Password", labText: "Password",
                      pre: Icon(Icons.lock_outline), suffix: IconButton(onPressed: (){
                        setState(() {
                          if(secure == true){
                            secure = false;
                          }else{
                            secure = true;
                          }
                        });
                      }, icon: Icon(secure == true ? Icons.visibility_outlined : Icons.visibility_off_outlined)), secure: secure),
                  btn(btnClr: Colors.blueAccent, btnTxt: "Sign Up",
                      onTap: () async{
                        UserCredential response = await signUp();
                        setState(() {
                          addUser();
                          FirebaseAuth.instance.currentUser!.sendEmailVerification();
                        });
                        print("================");
                        if(response != null){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Check your Email to Verify")));
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Login()));
                        }else{
                          print("signUp failed");
                        }
                        print("================");
                      }),
                  Center(child: Text("Or")),
                  btn(btnClr: Colors.white, btnTxt: "Log In", onTap: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Login()));
                  })
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
    required Icon pre,
    required var suffix,
    required bool secure,
}) => Expanded(
  child:   TextFormField(
      onSaved: onSaved,
      controller: ctrl,
      validator: (val){
        if(val!.length> 100){
          return txt1;
        }
        if(val.length < num){
          return txt2;
        }
        return null;
      },
      keyboardType: txtInput,
      obscureText: secure,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent,width: 2)
        ),
        hintText: hntTxt,
        labelText: labText,
        border: OutlineInputBorder(),
        prefixIcon: pre,
        suffixIcon: suffix,
      ),
    ),
);
  Widget btn({
    required Color btnClr,
    required String btnTxt,
    required void Function()? onTap,
}) =>Expanded(
  child:   Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        color: btnClr,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),side: BorderSide(width: 3,color: Colors.blueAccent)),
        child:   ListTile(
          title: Center(child: Text(btnTxt,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
          onTap: onTap,
        ),
      ),
    ),
);
}