
import 'package:flutter/material.dart';
class home extends StatelessWidget {
  const home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("YAHOOOOOO",style: TextStyle(color: Colors.red,fontSize: 50),),
        ],
      ),
    );
  }
}
