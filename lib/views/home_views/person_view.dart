import 'package:flutter/material.dart';
class person extends StatefulWidget {
  const person({Key? key}) : super(key: key);

  @override
  State<person> createState() => _personState();
}

class _personState extends State<person> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.red,
        body: Center(
        child: Text('Home Page',
        style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold
    ),),)
    );
  }
}
