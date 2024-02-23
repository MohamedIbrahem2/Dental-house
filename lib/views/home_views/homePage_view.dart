import 'dart:ffi';

import 'package:dental_house/models/pData.dart';
import 'package:dental_house/provider/event_provider.dart';
import 'package:dental_house/views/home_views/notifications_list.dart';
import 'package:dental_house/views/home_views/upcoming_appointment.dart';
import 'package:dental_house/views/home_views/waiting_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<EventProvider>(context).lists;
    final provider = Provider.of<EventProvider>(context).events;
    return Consumer<EventProvider>(builder: (context,model,child){
      return Scaffold(
        backgroundColor: Colors.white,
        drawer: Drawer(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationsList()));
            }, icon: Icon(Icons.notifications,color: Colors.white,)),
          ],
          backgroundColor: Colors.blueAccent,
          title: Text("Dental House",style: TextStyle(color: Colors.white),),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  flex: 1,
                  child: Text("Welcome Back \n DR, Mohamed Ibrahem",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
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
                              }, num1: provider.length.toString(), num2: '2'),
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
                              }, num1: prov.length.toString(), num2: '3')
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
