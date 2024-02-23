import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_house/models/pData.dart';
import 'package:dental_house/models/adult_painter.dart';
import 'package:dental_house/provider/event_provider.dart';
import 'package:dental_house/views/Patients_Info_views/add_dental_notes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:touchable/touchable.dart';

class DentalChart extends StatefulWidget {

  final MyData myList;
  const DentalChart({Key? key,
    required this.myList,
  }) : super(key: key);

  @override
  State<DentalChart> createState() => _DentalChartState();
}

class _DentalChartState extends State<DentalChart> {


  @override
  Widget build(BuildContext context) {
    return Consumer<EventProvider>(builder: (context,model,child) {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: Colors.blueAccent,
            appBar: AppBar(
              actions: [
                model.clicked == false ?
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> AddDentalNotes()));
                },
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                    child: Text("ADD +"))
                    : Text('')
              ],
              leading: IconButton(onPressed: () {
                Navigator.pop(context);
                model.selectedTeethPart.clear();
                model.clicked = true;
              }, icon: Icon(Icons.arrow_back, color: Colors.white,)),
              backgroundColor: Colors.blueAccent,
              title: model.clicked == false ?
                  Text(model.selectedTeethPart.length.toString() + " Selected",style: const TextStyle(color: Colors.white),)
                  : Text(
                "Dental Chart", style: TextStyle(color: Colors.white),),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipOval(
                        child: SvgPicture.asset("images/contacts.svg",
                          width: 100,
                          height: 100,
                        ),
                      ),
                      Text(widget.myList.fName + " " + widget.myList.lName,
                        style: TextStyle(color: Colors.white),),
                    ],
                  ),
                ),
                SizedBox(height: 50,
                  child: AppBar(
                    bottom: const TabBar(
                      tabs: [
                      Tab(child: Text("ADULT")),
                      Tab(child: Text("PEDIATRIC"))
                    ],

                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(children: [
                    SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        elevation: 4.0,
                              child: CanvasTouchDetector(
                                builder: (context) =>
                                    CustomPaint(
                                      painter: AdultPainter(context: context, model: model,svg: 'images/chart.svg',id: widget.myList.id),
                                    ),
                              )



                      ),
                    ),
                    SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        elevation: 4.0,
                        child: CanvasTouchDetector(
                          builder: (context) =>
                              CustomPaint(
                                painter: AdultPainter(context: context, model: model,svg: "images/lol.svg",id: widget.myList.id),
                              ),
                        )
                      ),
                    ),
                  ]),
                )
              ],
            )
        ),
      );

    });
  }


}