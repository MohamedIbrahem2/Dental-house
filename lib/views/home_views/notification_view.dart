import 'package:flutter/material.dart';
class notifi extends StatefulWidget {
  const notifi({Key? key}) : super(key: key);

  @override
  State<notifi> createState() => _notifiState();
}

class _notifiState extends State<notifi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.black,
        body: Center(
        child: Text('Notifacation Page',
        style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold
    ),),)
    );
  }
}
