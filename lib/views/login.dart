
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
  bool secure = true;
  bool  _isLoading = false;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  var mypassword , myemail;

  signIn() async{
    var formdata = formstate.currentState;
    if(formdata!.validate()){
      formdata.save();
      try {
        _isLoading = true;
        setState(() {

        });
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
          ).show();
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
          ).show();
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
      resizeToAvoidBottomInset: false,
      appBar: null,
      body:
      Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset("images/login-01.png", fit: BoxFit.fill,),
          ),
          Form(
            key: formstate,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: IconButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        icon: Icon((Icons.arrow_back_ios),color: Colors.white,)
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text("Welcome \nBack",style: TextStyle(
                      color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold
                    )),
                  ),
                  txtField(onSaved: (val){
                    myemail = val;
                  }, ctrl: email, txt1: "Email can't to be longer than 100 letter",
                      txt2: "Email can't to be less than 2 letter",
                      num: 2, txtInput: TextInputType.emailAddress, hntTxt: "Type Email", labText: "Email",
                      pre: Icon(Icons.email_outlined), suffix: null, secure: false),
                  txtField(onSaved: (val){
                    mypassword = val;
                  }, ctrl: pass, txt1: "Password can't to be longer than 100 letter",
                      txt2: "Password can't to be less than 4 letter",
                      num: 4, txtInput: TextInputType.visiblePassword, hntTxt: "Type Password", labText: "Pass",
                      pre: Icon(Icons.lock_outline), suffix: IconButton(onPressed: (){
                        setState(() {
                          if(secure == true){
                            secure = false;
                          }else{
                            secure = true;
                          }
                        });
                      }, icon: Icon(secure == true ? Icons.visibility_outlined : Icons.visibility_off_outlined)), secure: secure),
                  Center(child: TextButton(onPressed: (){}, child: Text("Forget Password?"))),
                  btn(btnClr: Colors.blueAccent, btnTxt: "Log In",
                      onTap: ()async{
                        var user =  await signIn();
                        if(user != null){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>home()));
                      }


                  }),
                  Center(child: Text("Or")),
                  btn(btnClr: Colors.white, btnTxt: "Sign Up",
                      onTap: (){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>signup()));
                      }),
                ],
              ),
            ),
          ),
          _isLoading ? Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ) : SizedBox()
        ],
      ),
    );
  }
  Widget txtField({
    required void Function(String?)? onSaved,
    required TextEditingController ctrl,
    required String txt1,
    required String txt2,
    required int num,
    required TextInputType? txtInput,
    required String hntTxt,
    required String labText,
    required Icon pre,
    required var suffix,
    required bool secure,
  }) => Expanded(
    child:   TextFormField(
      onSaved: onSaved,
      controller: ctrl,
      validator: (val){
        if(val!.length> 100){
          return txt1;
        }
        if(val.length < num){
          return txt2;
        }
        return null;
      },
      keyboardType: txtInput,
      obscureText: secure,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent,width: 2)
        ),
        hintText: hntTxt,
        labelText: labText,
        border: OutlineInputBorder(),
        prefixIcon: pre,
        suffixIcon: suffix,
      ),
    ),
  );
  Widget btn({
    required Color btnClr,
    required String btnTxt,
    required void Function()? onTap,
  }) =>Expanded(
    child:   Padding(
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
    ),
  );
}