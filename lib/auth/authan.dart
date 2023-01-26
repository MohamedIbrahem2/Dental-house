import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AuthService {
  final auth = FirebaseAuth.instance;
  final email = TextEditingController();
  final password  = TextEditingController();

  void LogInUser () async {
    try {
      await auth.signInWithEmailAndPassword(email: email.text, password: password.text).then((value){
        print("user is loged in");
      });
    } catch(e){print (e);}
  }

  void RegisterUser () async {
    try {
      await auth.createUserWithEmailAndPassword(email: email.text, password: password.text).then((value){
        print("user is regestred");
      });
    } catch(e){print (e);}
  }
  void LogOut () async {
    await auth.signOut();
  }
}

