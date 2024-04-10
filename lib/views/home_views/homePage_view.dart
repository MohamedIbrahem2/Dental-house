import 'package:dental_house/provider/event_provider.dart';
import 'package:dental_house/views/home_views/notifications_list.dart';
import 'package:dental_house/views/home_views/upcoming_appointment.dart';
import 'package:dental_house/views/home_views/waiting_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/teeth_part.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
String patients = '';
String events = '';
String waiting = '';

String? myToken;
getToken()async{
  myToken = await FirebaseMessaging.instance.getToken();
  print(myToken);
  print("==============================");
}

  void getPatientsNum() {
    users.doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("patients")
        .get().then((value) {
      var fields = value.docs;
      setState(() {
        if(fields.isEmpty){
          patients = '0';
        }else{
          patients = fields.length.toString();
        }

      });
    });
  }
void getWaitingNum() {
  users.doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("waitingList")
      .get().then((value) {
    var fields = value.docs;
    setState(() {
      if(fields.isEmpty){
        waiting = '0';
      }else{
        waiting = fields.length.toString();
      }
    });
  });
}
void getEventNum() {
  users.doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("events")
      .get().then((value) {
    var fields = value.docs;
    setState(() {
      if(fields.isEmpty){
        events = '0';
      }else{
        events = fields.length.toString();
      }
    });
  });
}
  @override
  void initState(){
    super.initState();
    getPatientsNum();
    getEventNum();
    getWaitingNum();
    getToken();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<EventProvider>(builder: (context,model,child){
      return Scaffold(
        appBar: PreferredSize(preferredSize: Size.fromHeight(125),
            child:
            Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(25)
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 35,left: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Dental House",style: TextStyle(
                          color: Colors.white,fontSize: 22
                        ),),
                        IconButton(onPressed: (){}, icon: Icon(Icons.notifications,color: Colors.white,))
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: ClipOval(
                            child: Image.asset("images/person.png",fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Welcome",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                              Text("Dr / Mohamed Ibrahem",style: TextStyle(color: Colors.white,fontSize: 15),)
                            ],
                          ),
                        )
                      ]
                    )
                  ],
                  
                ),
              ),
            )
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Card(
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
                    elevation: 4.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          head(headTxt: 'Appointment', headIcon: Icon(Icons.add), onPress: () {
                            model.changePage(4);
                          }),
                          card(txt1: 'Today', txt2: 'Upcoming', icn1: Icon(Icons.remove_red_eye),
                              icn2: Icon(Icons.upcoming), onPress1: () {
                            model.changePage(4);
                              }, onPress2: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> UpComing()));
                              }, num1: events, num2: '0'),
                          head(headTxt: 'Patients', headIcon: Icon(Icons.add), onPress: () {
                            model.changePage(3);
                          }),
                          card(txt1: 'Total Patients', txt2: 'On waiting list'
                              , icn1: Icon(Icons.person), icn2: Icon(Icons.pending),
                              onPress1: () {
                            model.changePage(1);
                              },
                              onPress2: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>WaitingList()));
                              }, num1: patients, num2: waiting)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

      );
    });
  }
  Widget head ({
    required String headTxt,
    required Icon headIcon,
    required void Function()? onPress,
})=> Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(headTxt,style: TextStyle(
            fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black
        ),),
      ),
      IconButton(onPressed: onPress, icon: headIcon)
    ],
  );
  Widget card ({
    required String txt1,
    required String txt2,
    required String num1,
    required String num2,
    required Icon icn1,
    required Icon icn2,
    required void Function()? onPress1,
    required void Function()? onPress2,
})=> Padding(
  padding: const EdgeInsets.all(5.0),
  child: Card(
    color: Colors.white,
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child:   Column(
      children: [
        ListTile(
          leading: Text(num1,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
          title: Text(txt1,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
          trailing: icn1,
          onTap: onPress1,
        ),
        ListTile(
          leading: Text(num2,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),) ,
          title: Text(txt2,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
          trailing: icn2,
          onTap: onPress2,
        ),
      ],
    ),

  ),
);
}
