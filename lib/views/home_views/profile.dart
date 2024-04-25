import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_house/provider/event_provider.dart';
import 'package:dental_house/views/home_views/profile_views/help_center.dart';
import 'package:dental_house/views/home_views/profile_views/profile_info.dart';
import 'package:dental_house/views/home_views/profile_views/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/pData.dart';
import '../login.dart';
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);



  @override
  State<Profile> createState() => _ProfileState();
}


class _ProfileState extends State<Profile> {
  String name = '';
  String photo = '';
  late String pic;
  bool ispic = false;
  File? image;
  late String url;
  CollectionReference users = FirebaseFirestore.instance.collection('Dental House');
  void getUsersData() {
    users.doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("info")
        .doc("info")
        .get().then((value) {
      var fields = value.data();
      setState(() {
        name = fields?['first_name'] + fields?['last_name'];
      });
    });
  }
  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      photo = prefs.getString('photo') ?? '';
    });
  }
  Future<void> addPhoto() async{
    final prefs = await SharedPreferences.getInstance();
    final ref = FirebaseStorage.instance
        .ref()
        .child('doctorsimages')
        .child(name + '.jpg');
        await ref.putFile(image!);
        url = await ref.getDownloadURL();
        prefs.setString('photo', url);
    return users
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('info')
        .doc('photo')
        .set({
      'photo': url,
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
  Future pickImage() async{
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery);

      if (image == null) {
        return;
      }
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
      await addPhoto();

    } on PlatformException catch (e){
      print('Failed to pick image: $e');
    }
  }
  @override
  void initState(){
    super.initState();
    getUsersData();
    _loadPreferences();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Profile",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                  SizedBox(width: 115,height: 115,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                          ClipOval(
                            child: photo == '' ? Image.asset("images/person.png",fit: BoxFit.cover,
                            ) : Image.network(photo,fit: BoxFit.cover,
                  )
                          ),
                             // : FlutterLogo(),

                        Positioned(
                          right: 0,
                            bottom: 2,
                            child: SizedBox(width: 40,
                              height: 40,
                              child: TextButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                      side: BorderSide(color: Colors.white)
                                    ),
                                  ),
                                    backgroundColor: MaterialStateProperty.all(Colors.grey),
                                ),
                                onPressed: () async{
                                  pickImage();
                                },
                                child: SvgPicture.asset("images/camera.svg"),
                            ),
                        )
                        )
                      ],
                    ),
                  ),
                listAll(title: "My Account", leading: Icon(Icons.person_outline,color: Colors.blueAccent,),clr: Colors.white,onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> profile_info()));
                }),
                listAll(title: "Notifications", leading: Icon(Icons.notifications_none,color: Colors.blueAccent,),clr: Colors.white),
                listAll(onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Setting()));
                },title: "Settings", leading: Icon(Icons.settings_outlined,color: Colors.blueAccent,),clr: Colors.white),
                 listAll(onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>Help()));
                 },title: "Help Center", leading: Icon(Icons.info_outline_rounded,color: Colors.blueAccent,),clr: Colors.white),
                listAll(title: "Log Out", leading: Icon(Icons.logout_outlined,color: Colors.black,),clr: Colors.blueAccent, onTap: (){
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Login()));
                }),
              ],
            ),
          ),
      ),
    );
  }
  Widget listAll({
    required String title,
    required Icon leading,
    required Color clr,
    var onTap,
}) => Flexible(
  child:   Padding(

    padding: const EdgeInsets.all(10.0),

    child:   Card(

      color: clr,

      elevation: 3,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

      child:   ListTile(



          leading: leading,

          title: Text(title),

          trailing: Icon(Icons.arrow_forward_ios),
        onTap: onTap,


        ),

    ),

  ),
);

}
