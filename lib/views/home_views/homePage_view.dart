import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            color: Colors.white,
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),side: const BorderSide(width: 3,color: Colors.blueAccent)),
            child:   ListTile(
              title: Center(child: Text("appointment",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
            ),
          ),
        )
    );
  }
}
