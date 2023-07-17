import 'package:flutter/material.dart';
class settings extends StatefulWidget {
  const settings({Key? key}) : super(key: key);

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.green,
        body: Center(
        child: Text('Settings Page',
        style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold
    ),),)
    );
  }
}
