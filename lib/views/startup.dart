import 'package:dental_house/views/login.dart';
import 'package:dental_house/views/signup.dart';
import 'package:flutter/material.dart';
class startup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset("images/startup.png", fit: BoxFit.fill,),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 100.0, bottom: 20),
                  child: Text("DENTAL HOUSE",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only( bottom: 50),
                  child: Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.black87,
                  ),
                ),
                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));
                },
                    child: Text("Log in",
                      style: TextStyle(color: Colors.blueAccent,fontSize: 15,fontWeight: FontWeight.bold),),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        fixedSize: Size(400, 50),
                        primary: Colors.white,
                        side: BorderSide(width: 2,
                            color: Colors.blueAccent,
                            style: BorderStyle.solid)
                    )
                ),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>signup()));
                },
                    child: Text("Sign up",
                      style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                        fixedSize: Size(400, 50),
                        primary: Colors.blueAccent,
                        side: BorderSide(width: 2,
                            color: Colors.white,
                            style: BorderStyle.solid)
                    )
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}