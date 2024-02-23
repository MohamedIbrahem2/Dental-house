
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dental_house/views/home.dart';
import 'package:dental_house/views/signup.dart';
import 'package:dental_house/views/startup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);



  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  var currentFocus;

  unFocus() {
    currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
  bool secure = true;
  bool  _isLoading = false;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late String myPassword , myEmail;

  signIn() async{
    var formData = formState.currentState;
    if(formData!.validate()){
      formData.save();
      try {
        _isLoading = true;
        setState(() {

        });
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: myEmail,
            password: myPassword
        );
        if(userCredential.user!.emailVerified){
        }else{
          dialog(dialog: DialogType.success, text: "Check your email to Verify your Account").show();
        }
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          dialog(dialog: DialogType.error, text: "No user found for that email").show();
        } else if (e.code == 'wrong-password') {
          dialog(dialog: DialogType.error, text: "Wrong password provided for that user").show();
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: unFocus,
      child: Scaffold(
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
              key: formState,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: IconButton(
                          onPressed: (){
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> startup()));
                          },
                          icon: const Icon((Icons.arrow_back_ios),color: Colors.white,)
                      ),
                    ),
                    const Expanded(
                      flex: 4,
                      child: Text("Welcome \nBack",style: TextStyle(
                        color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold
                      )),
                    ),
                    txtField(onSaved: (val){
                      myEmail = val!;
                    }, ctrl: email, txt1: "Email can't to be longer than 100 letter",
                        txt2: "Email can't to be less than 2 letter",
                        num: 2, txtInput: TextInputType.emailAddress, hntTxt: "Type Email", labText: "Email",
                        pre: const Icon(Icons.email_outlined), suffix: null, secure: false),
                    txtField(onSaved: (val){
                      myPassword = val!;
                    }, ctrl: pass, txt1: "Password can't to be longer than 100 letter",
                        txt2: "Password can't to be less than 4 letter",
                        num: 4, txtInput: TextInputType.visiblePassword, hntTxt: "Type Password", labText: "Pass",
                        pre: const Icon(Icons.lock_outline), suffix: IconButton(onPressed: (){
                          setState(() {
                            if(secure == true){
                              secure = false;
                            }else{
                              secure = true;
                            }
                          });
                        }, icon: Icon(secure == true ? Icons.visibility_outlined : Icons.visibility_off_outlined)), secure: secure),
                    Center(child: TextButton(onPressed: () async{
                      if(email.text == ""){
                        dialog(dialog: DialogType.ERROR, text: "Please type your Email then press forget password").show();
                        return;
                      }
                      try {
                        await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
                        dialog(dialog: DialogType.SUCCES, text: "We send reset password link to your email").show();
                      }catch (e) {
                        dialog(dialog: DialogType.ERROR, text: "No user found For that Email").show();
                      }

                    }, child: const Text("Forget Password?"))),
                    btn(btnClr: Colors.blueAccent, btnTxt: "Log In",
                        onTap: ()async{
                          var user =  await signIn();
                          if(user != null && FirebaseAuth.instance.currentUser!.emailVerified){
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const Home()));
                        }else{
                            _isLoading = false;
                            setState(() {

                            });
                          }


                    }),
                    const Center(child: Text("Or")),
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
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ) : const SizedBox()
          ],
        ),
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
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent,width: 2)
        ),
        hintText: hntTxt,
        labelText: labText,
        border: const OutlineInputBorder(),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),side: const BorderSide(width: 3,color: Colors.blueAccent)),
        child:   ListTile(
          title: Center(child: Text(btnTxt,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
          onTap: onTap,
        ),
      ),
    ),
  );
  AwesomeDialog dialog ({
    required var dialog,
    required String text,
}) => AwesomeDialog(
      borderSide: const BorderSide(
      width: 3,
      color: Colors.blue
      ),
      context: context,
      title: "Error",
      dialogType: dialog,
      body: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(text,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
      ),
      );
}