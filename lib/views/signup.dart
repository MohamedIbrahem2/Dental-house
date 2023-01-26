import 'package:dental_house/auth/authan.dart';
import 'package:dental_house/views/home.dart';
import 'package:flutter/material.dart';

class signup extends StatelessWidget {
  TextEditingController name = TextEditingController();
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: null,
      body:
      Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset("images/login-01.png", fit: BoxFit.fill,),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 300,top: 30),
                  child: IconButton(
                      onPressed: (){},
                      icon: Icon((Icons.arrow_back_ios),color: Colors.white,)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 200,bottom: 200,top: 150),
                  child: Text("Create \nAccount",style: TextStyle(
                      color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: name,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent)
                      ),
                      hintText: "Type Name",
                      labelText: "Name",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                      suffixIcon: Icon(Icons.check),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: authService.email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent)
                      ),
                      hintText: "Type Email",
                      labelText: "Email",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email_outlined),
                      suffixIcon: Icon(Icons.check),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: authService.password,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent)
                      ),
                      hintText: "Type Password",
                      labelText: "Password",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: Icon(Icons.remove_red_eye),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(onPressed: (){
                    if(authService.email != "" && authService.password != ""){
                      authService.LogInUser();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> home()));
                    }
                  },
                      child: Text("Sign Up",
                        style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          fixedSize: Size(400, 50),
                          primary: Colors.blueAccent,
                          side: BorderSide(width: 2,
                              color: Colors.blueAccent,
                              style: BorderStyle.solid)
                      )
                  ),
                ),
                SizedBox(height: 10,),
                Text("Or"),
                SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(onPressed: (){},
                      child: Text("Log in",
                        style: TextStyle(color: Colors.grey,fontSize: 15,fontWeight: FontWeight.bold),),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                          fixedSize: Size(400, 50),
                          primary: Colors.white,
                          side: BorderSide(width: 2,
                              color: Colors.black,
                              style: BorderStyle.solid)
                      )
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}