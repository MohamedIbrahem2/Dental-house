
import 'package:dental_house/views/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dental_house/views/home.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';


class signup extends StatefulWidget {
  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  var username , myemail, password;

  TextEditingController name = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController pass = TextEditingController();

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  signUp() async {
    var formdata = formstate.currentState;
    if(formdata!.validate()){
      formdata.save();

      try {
              UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: myemail,
                  password: password
              );
              return userCredential;
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                AwesomeDialog(
                  borderSide: BorderSide(
                      width: 3,
                      color: Colors.blue
                  ),
                  context: context,
                  title: "Error",
                  body: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text("password is too weak",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  ),
                )..show();
                print('The password provided is too weak.');
              } else if (e.code == 'email-already-in-use') {
                AwesomeDialog(
                  borderSide: BorderSide(
                    width: 3,
                    color: Colors.blue
                  ),
                  context: context,
                  title: "Error",
                  body: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text("The account already exists for that email",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                  ),
                )..show();
                print('The account already exists for that email.');
              }
            } catch (e) {
              print(e);
            }
    }else{
      print("Not Valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body:
      Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset("images/login-01.png", fit: BoxFit.fill,),
          ),
          Form(
            key: formstate,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 250,top: 50),
                      child: IconButton(
                          onPressed: (){},
                          icon: Icon((Icons.arrow_back_ios),color: Colors.white,)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 150,top: 80,bottom: 95),
                      child: Text("Create \nAccount",style: TextStyle(
                          color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold
                      )),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onSaved: (val){
                        username = val;
                      },
                      controller: name,
                      validator: (val){
                        if(val!.length > 100){
                          return "username can't to be longer than 100 letter";
                        }
                        if(val.length < 2){
                          return "username can't to be less than 2 latter";
                        }
                        return null;
                      },
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
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onSaved: (val){
                        myemail = val;
                      },
                      controller: email,
                      validator: (val){
                        if(val!.length> 100){
                          return "Email can't to be longer than 100 letter";
                        }
                        if(val.length < 2){
                          return "Email can't to be less than 2 latter";
                        }
                        return null;
                      },
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
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onSaved: (val){
                        password = val;
                      },
                      controller: pass,
                      validator: (val){
                        if(val!.length > 100){
                          return "password can't to be longer than 100 letter";
                        }
                        if(val.length < 4){
                          return "password can't to be less than 4 latter";
                        }
                        return null;
                      },
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
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(onPressed: () async{
                      UserCredential response = await signUp();
                      print("================");
                      if(response != null){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> home()));
                      }else{
                        print("signUp failed");
                      }
                      print("================");
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
                ),
                SizedBox(height: 10,),
                Text("Or"),
                SizedBox(height: 5,),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(onPressed: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>login()));
                    },
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}