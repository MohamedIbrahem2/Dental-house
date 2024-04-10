import 'package:flutter/material.dart';
class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);


  @override
  State<Setting> createState() => _Setting();
}

class _Setting extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back)),
        backgroundColor: Colors.blueAccent,
        title: Text("Settings"),
      ),
      body: Column(
        children: [
          listAll(title: "Change Email",),
          listAll(title: "Change Password"),
          listAll(title: "Language"),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Notifications",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                Switch(value: false, onChanged: null,activeColor: Colors.blueAccent,inactiveThumbColor: Colors.blueAccent,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Dark Mode",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                Switch(value: false, onChanged: null,activeColor: Colors.blueAccent,inactiveThumbColor: Colors.blueAccent,),
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget listAll({
    required String title,
    var onTap,
  }) => Flexible(
    child:   Padding(

      padding: const EdgeInsets.all(10.0),

      child:   Card(

        color: Colors.white,

        elevation: 3,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

        child:   ListTile(



          title: Text(title),

          trailing: Icon(Icons.arrow_forward_ios),
          onTap: onTap,


        ),

      ),

    ),
  );
}
