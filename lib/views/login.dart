
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dental_house/views/home.dart';
import 'package:dental_house/views/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class login extends StatefulWidget {


  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  var mypassword , myemail;

  signIn() async{
    var formdata = formstate.currentState;
    if(formdata!.validate()){
      formdata.save();
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: myemail,
            password: mypassword
        );
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          AwesomeDialog(
            borderSide: BorderSide(
                width: 3,
                color: Colors.blue
            ),
            context: context,
            title: "Error",
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("No user found for that email.",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            ),
          )..show();
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          AwesomeDialog(
            borderSide: BorderSide(
                width: 3,
                color: Colors.blue
            ),
            context: context,
            title: "Error",
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("Wrong password provided for that user.",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            ),
          )..show();
          print('Wrong password provided for that user.');
        }
      }

    }else{
      print("NOT valid");
    }
  }
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
          Form(
            key: formstate,
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
                    autofillHints: [AutofillHints.email],
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
                    onSaved: (val){
                      mypassword = val;
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
                          },
                          icon: Icon(Icons.remove_red_eye,color:Colors.blueAccent), ),
                    ),
                  ),
                ),
                TextButton(onPressed: (){}, child: Text("Forget Password?")),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(onPressed: () async{
                    var user =  await signIn();
                    if(user != null){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>home()));
                    }
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
                  child: ElevatedButton(onPressed: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>signup()));
                  },
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
        ],
      ),
    );
  }
}