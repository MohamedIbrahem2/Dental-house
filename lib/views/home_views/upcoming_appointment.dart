import 'package:flutter/material.dart';
class UpComing extends StatefulWidget {
  const UpComing({Key? key}) : super(key: key);


  @override
  State<UpComing> createState() => _UpComingState();
}

class _UpComingState extends State<UpComing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back)),
        backgroundColor: Colors.blueAccent,
        title: Text("Upcoming Appointments"),
      ),
      body: Center(child: Text("No Upcoming appointments"),),
    );
  }
}
