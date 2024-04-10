import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);


  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back)),
        backgroundColor: Colors.blueAccent,
        title: Text("Help Center"),
      ),
      body: Column(
        children: [
          Center(child: Text("Need Some Help ?",style:
          TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),),
          TextButton(onPressed: (){
            _makeEmail("mohamedibra031@gmail.com");
          }, child: Text("Submit your request using email and i will try to help you ASAP",style:
            TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold),))
        ],
      ),
    );
  }
  Future<void> _makeEmail(String emailUrl) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: emailUrl,
    );
    await launchUrl(launchUri);
  }
}
