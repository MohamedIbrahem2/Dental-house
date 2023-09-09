
import 'package:dental_house/views/home_views/calendar_view.dart';
import 'package:dental_house/views/home_views/notification_view.dart';
import 'package:dental_house/views/home_views/person_view.dart';
import 'package:dental_house/views/home_views/profile.dart';
import 'package:dental_house/views/home_views/settings_view.dart';
import 'package:dental_house/views/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
class home extends StatefulWidget {

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  getUser() async {
    var user = FirebaseAuth.instance.currentUser;
    print(user?.email);
  }
  @override
  void initState(){
    getUser();
    super.initState();
  }
  int SelectedPage = 0;

  final _pageNo = [person(),notifi(),profile(),settings(),calendar()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> login()));
            },
            icon: Icon(Icons.logout))
      ),
      bottomNavigationBar: ConvexAppBar(
          items:[
            TabItem(icon: Icons.calendar_month, title: 'person'),
            TabItem(icon: Icons.notification_add, title: 'notifi'),
            TabItem(icon: Icons.add,title: 'profile'),
            TabItem(icon: Icons.settings, title: 'settings'),
            TabItem(icon: Icons.person, title: 'calendar')
          ],
        style: TabStyle.reactCircle,
        initialActiveIndex: SelectedPage,
    onTap: (int i){
            setState(() {
              SelectedPage = i;
            });
    },
      ),
      body:
      _pageNo[SelectedPage],
    );
  }
}
