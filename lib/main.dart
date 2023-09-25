
import 'package:dental_house/provider/event_provider.dart';
import 'package:dental_house/views/home.dart';
import 'package:dental_house/views/home_views/calendar_view.dart';
import 'package:dental_house/views/home_views/profile.dart';
import 'package:dental_house/views/login.dart';
import 'package:dental_house/views/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
bool isLogin = true;

void main() {
  /*WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var user = FirebaseAuth.instance.currentUser;
  if(user == null){
    isLogin = false;
  }else{
    isLogin = true;
  }
   */

  runApp(
    ChangeNotifierProvider(create: (context)=> EventProvider(),
      child:MaterialApp(
    debugShowCheckedModeBanner: false,
    themeMode: ThemeMode.dark,
    //home: isLogin == false ? splash() : home(),
    home : profile()
    //home: home(),
  )
    )
  );
}