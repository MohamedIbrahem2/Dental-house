import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Text("Profile",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                  SizedBox(width: 115,height: 115,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage("images/mody.jpg"),
                        ),
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
                                onPressed: (){},
                                child: SvgPicture.asset("images/camera.svg"),
                            ),
                        )
                        )
                      ],
                    ),
                  ),
                const SizedBox(height: 32,),
                listAll(title: "name", leading: Icon(Icons.person)),
                const SizedBox(height: 32,),
                listAll(title: "E-mail", leading: Icon(Icons.mail)),
                const SizedBox(height: 32,),
                listAll(title: "dentist", leading: Icon(Icons.format_indent_increase)),
                const SizedBox(height: 32,),
                listAll(title: "age", leading: Icon(Icons.real_estate_agent))
              ],
            ),
          ),
      ),
    );
  }
  Widget listAll({
    required String title,
    required Icon leading,
}) => ListTile(
    leading: leading,
    title: Text(title),
  );
}
