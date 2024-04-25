
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_house/provider/event_provider.dart';
import 'package:dental_house/views/Patients_Info_views/patients_photo.dart';
import 'package:dental_house/views/home.dart';
import 'package:dental_house/views/startup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'models/teeth_part.dart';
bool isLogin = false;
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.notification!.title);
  print(message.notification!.body);
}
void main() async {
  WidgetsBinding widgetsBinding =  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  var user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    isLogin = false;

  } else {
    isLogin = true;
  }
  FlutterNativeSplash.remove();
  runApp( MyApp());
}

  class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


    @override
    Widget build(BuildContext context) {
      return MultiProvider(providers: [
        ChangeNotifierProvider.value(value: EventProvider()),
      ],
        child:MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.blueAccent
                ),
          ),
            debugShowCheckedModeBanner: false,
            home: isLogin == false ? startup() : const Home(),
          //home: home(),
        ),

      );
    }

    sendMessage(title, message)async{
      var headersList = {
        'Accept': '*/*',
        'Content-Type': 'application/json',
        'Authorization': 'key=AAAARQxQcaA:APA91bEiZAwa0eX2gh_NwmftLwTiGj1ILfq71Ua8L2WN6NJHp1p6bxwNOz3nKMtpXmnOE7_aQQIUKQAZvEYVpyFLEUAKQxJkURHLGb3kZwSfyMED8ViyfMtJ2s6zGu5MWlhXLom3FCni'
      };
      var url = Uri.parse('https://fcm.googleapis.com/fcm/send');

      var body = {
        "to": "cg7j9zm1SPeEuhVlsoqnbU:APA91bH7LW8ENk9N1LZwT5magTyntQWDGuGBG16yHXI-Hq0Qrim15AXD8bteaXkQ9b7PbyD0oN2-IWprhsM9f2R2ckVksCwGN5gn8IkT9lp44U53sBK_S6H9PfK2-UbELZzF6SfO7KPD",
        "notification": {
          "title": title,
          "body": message,
        }
      };

      var req = http.Request('POST', url);
      req.headers.addAll(headersList);
      req.body = json.encode(body);


      var res = await req.send();
      final resBody = await res.stream.bytesToString();

      if (res.statusCode >= 200 && res.statusCode < 300) {
        print(resBody);
      }
      else {
        print(res.reasonPhrase);
      }
    }
}


