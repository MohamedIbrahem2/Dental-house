import 'package:dental_house/views/home.dart';
import 'package:dental_house/views/home_views/calendar_view.dart';
import 'package:dental_house/views/login.dart';
import 'package:dental_house/views/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
bool isLogin = true;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var user = FirebaseAuth.instance.currentUser;
  if(user == null){
    isLogin = false;
  }else{
    isLogin = true;
  }
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    //home: isLogin == false ? splash() : home(),
    home : calendar()
    //home: home(),
  ));
}