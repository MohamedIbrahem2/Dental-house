
import 'package:dental_house/provider/event_provider.dart';
import 'package:dental_house/views/home.dart';
import 'package:dental_house/views/startup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
bool isLogin = false;

void main() async {
  WidgetsBinding widgetsBinding =  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  var user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    isLogin = false;

  } else {
    isLogin = true;
  }
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

  class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


    @override
    Widget build(BuildContext context) {
      return MultiProvider(providers: [
        ChangeNotifierProvider.value(value: EventProvider()),
      ],
        child:MaterialApp(
            debugShowCheckedModeBanner: false,
            home: isLogin == false ? startup() : const Home(),
            //home : calendar()
          //home: home(),
        ),

      );
    }
  }


