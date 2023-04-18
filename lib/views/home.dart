
import 'package:dental_house/views/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  getUser() async {
    var user = FirebaseAuth.instance.currentUser;
    print(user?.email);
  }
  @override
  void initState(){
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOME"),
        actions: [
          IconButton(icon: Icon(Icons.exit_to_app),onPressed: () async{
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>login()));
          },),
        ],
      ),
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
