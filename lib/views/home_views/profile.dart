import 'package:flutter/material.dart';
class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.blueAccent,
        body: Center(
        child: Text('Profile Page',
        style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold
    ),),)
    );
  }
}
