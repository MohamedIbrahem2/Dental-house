import 'package:dental_house/views/home.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import '../auth/authan.dart';
class login extends StatefulWidget {


  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  AuthService authService = AuthService();
  bool check = true;
  final _formkey = GlobalKey<FormState>();
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
            child: Form(
              key: _formkey,
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
                    child: Text("Welcome \nBack",style: TextStyle(
                      color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: authService.email,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: [AutofillHints.email],
                      validator: (String? value){
                        if(value!.isEmpty){
                          return "Please Enter Your Email";
                        }
                        else if(!EmailValidator.validate(value,true)){
                          return 'Invalid Email Address';
                        }
                        _formkey.currentState!.save();
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent)
                        ),
                        hintText: "Type Email",
                        labelText: "Email",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: authService.password,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: check,
                      validator: (String? value){
                        if(value!.length < 8){
                          return "Password Should be minimum 8 characters";
                        }
                        _formkey.currentState!.save();
                        return null;
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent)
                        ),
                        hintText: "Type Password",
                        labelText: "Password",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                            onPressed: () {
                              check = !check;
                              setState(() {

                              });
                            },
                            icon: Icon(Icons.remove_red_eye,color: check? Colors.blueAccent : Colors.red), ),
                      ),
                    ),
                  ),
                  TextButton(onPressed: (){}, child: Text("Forget Password?")),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(onPressed: (){
                      if(authService.email != "" && authService.password != ""){
                        authService.LogInUser();
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> home()));
                      }
                      return;
                    },
                        child: Text("Log in",
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
                        child: Text("Sign up",
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
          ),
        ],
      ),
    );
  }
}