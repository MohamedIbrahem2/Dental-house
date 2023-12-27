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
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset("images/startup.png", fit: BoxFit.fill,),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("DENTAL HOUSE",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 20,),
                btn(btnClr: Colors.white, btnTxt: "Log In",
                    onTap: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Login()));
                    }),
                btn(btnClr: Colors.blueAccent, btnTxt: "Sign Up",
                    onTap: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>signup()));
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget btn({
    required Color btnClr,
    required String btnTxt,
    required void Function()? onTap,
  }) =>Padding(
    padding: const EdgeInsets.all(5.0),
    child: Card(
      color: btnClr,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),side: BorderSide(width: 3,color: Colors.blueAccent)),
      child:   ListTile(
        title: Center(child: Text(btnTxt,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
        onTap: onTap,
      ),
    ),
  );
}