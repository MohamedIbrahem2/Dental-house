import 'package:flutter/material.dart';
class WaitingList extends StatefulWidget {
  const WaitingList({Key? key}) : super(key: key);



  @override
  State<WaitingList> createState() => _WaitingListState();
}

class _WaitingListState extends State<WaitingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back)),
        backgroundColor: Colors.blueAccent,
        title: Text("Waiting List"),
      ),
      body: Center(child: Text("No Patients on waiting list"),),
    );
  }
}
