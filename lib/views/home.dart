
import 'package:dental_house/provider/event_provider.dart';
import 'package:dental_house/views/home_views/calendar_view.dart';
import 'package:dental_house/views/home_views/patientList_view.dart';
import 'package:dental_house/views/home_views/homePage_view.dart';
import 'package:dental_house/views/home_views/profile.dart';
import 'package:dental_house/views/home_views/newPatient_view.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:provider/provider.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final _pageNo = [ const profile(), const PatientList(),const HomePage(),const NewPatient(),const Calendar()];
  @override
  Widget build(BuildContext context) {
    return Consumer<EventProvider>(builder: (context, model,child){
      return Scaffold(
        appBar: null,
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: Colors.blueAccent,
          items:const [
            TabItem(icon: Icons.person_outline, title: 'Profile'),
            TabItem(icon: Icons.contact_page_outlined, title: 'P List'),
            TabItem(icon: Icons.home_outlined,title: 'Home'),
            TabItem(icon: Icons.add, title: 'New P'),
            TabItem(icon: Icons.calendar_month, title: 'Calendar')
          ],
          style: TabStyle.fixedCircle,
          initialActiveIndex: model.selectedPage,
          elevation: 5,
          onTap: (int i){
            setState(() {
              model.selectedPage = i;
            });
          },
        ),
        body:
        _pageNo[model.selectedPage],
      );
    },
    );
  }
}
