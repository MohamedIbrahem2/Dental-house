import 'dart:io';
import 'package:dental_house/views/home_views/profile_views/profile_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  late String pic;
  bool ispic = false;
  File? image;
  Future pickImage() async{
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery);

      if (image == null) {
        return;
      }
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e){
      print('Failed to pick image: $e');
    }
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
                        image != null ?
                          ClipOval(
                            child: Image.file(image!,fit: BoxFit.cover,
                            ),
                          )
                              : FlutterLogo(),

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
                                onPressed: () {
                                  pickImage();
                                },
                                child: SvgPicture.asset("images/camera.svg"),
                            ),
                        )
                        )
                      ],
                    ),
                  ),
                listAll(title: "My Account", leading: Icon(Icons.person_outline,color: Colors.blueAccent,),clr: Colors.white),
                listAll(title: "Notifications", leading: Icon(Icons.notifications_none,color: Colors.blueAccent,),clr: Colors.white),
                listAll(title: "Settings", leading: Icon(Icons.settings_outlined,color: Colors.blueAccent,),clr: Colors.white),
                 listAll(title: "Help Center", leading: Icon(Icons.info_outline_rounded,color: Colors.blueAccent,),clr: Colors.white),
                listAll(title: "Log Out", leading: Icon(Icons.logout_outlined,color: Colors.black,),clr: Colors.blueAccent),
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
        onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> profile_info()));
        },


        ),

    ),

  ),
);

}
