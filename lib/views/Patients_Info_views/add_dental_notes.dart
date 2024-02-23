import 'package:dental_house/provider/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/pData.dart';
import '../editing/Utils.dart';
class AddDentalNotes extends StatefulWidget {
  const AddDentalNotes({Key? key}) : super(key: key);


  @override
  State<AddDentalNotes> createState() => _AddDentalNotesState();
}

class _AddDentalNotesState extends State<AddDentalNotes> {
  TextEditingController dateController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  bool click = true;
  bool click1 = false;
  bool click2 = false;
  bool click3 = false;
  bool click4 = false;
  bool click5 = false;
  bool click6 = false;
  bool click7 = false;
  bool click8 = false;

  late DateTime fromDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back, color: Colors.white,)),
        title: const Text(
          "Add Dental Notes", style: TextStyle(color: Colors.white),),
      ),
      body: Consumer<EventProvider>(
        builder: (context, model,child) {
          return SingleChildScrollView(
            child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text("Tooth Number",style: TextStyle(
                fontWeight: FontWeight.bold
            )),
               SizedBox(
                 height: 10,
               ),

               SizedBox(
                 height: 50,
                 width: double.infinity,
                 child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: model.selectedTeethPart.length,
                  itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.red,
                      width: 30,
                      height: 30,
                      child: Center(child: Text(model.selectedTeethPart[index],style: TextStyle(color: Colors.white),)),
                    ),
                  );
                             },

                             ),
               ),
              SizedBox(
                height: 20,
              ),


            Text("Choose a color",style: TextStyle(
                fontWeight: FontWeight.bold
            )),
              SizedBox(
                height: 20,
              ),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
                InkWell(
                  onTap: (){
                    click = !click;
                    setState(() {

                    });
                  },
                    child: colors(clr: Colors.grey, brdr: click ? Border.all(
                        color: Colors.black,
                        width: 2
                    ) : null)),
            GestureDetector(
              onTap: (){
                click1 = !click1;
                setState(() {

                });
              },
                child: colors(clr: Colors.yellow,brdr: click1 ? Border.all(
                  color: Colors.black,
                  width: 2
                ) : null
            ),
            ),
            GestureDetector(
                onTap: (){
                  click2 = !click2;
                  setState(() {

                  });
                },
                child: colors(clr: Colors.red, brdr: click2 ? Border.all(
                    color: Colors.black,
                    width: 2
                ) : null)),
            GestureDetector(
                onTap: (){
                  click3 = !click3;
                  setState(() {

                  });
                },
                child: colors(clr: Colors.green, brdr: click3 ? Border.all(
                    color: Colors.black,
                    width: 2
                ) : null)),
            GestureDetector(
                onTap: (){
                  click4 = !click4;
                  setState(() {

                  });
                },
                child: colors(clr: Colors.blue, brdr: click4 ? Border.all(
                    color: Colors.black,
                    width: 2
                ) : null)),
            GestureDetector(
                onTap: (){
                  click5 = !click5;
                  setState(() {

                  });
                },
                child: colors(clr: Colors.orange, brdr: click5 ? Border.all(
                    color: Colors.black,
                    width: 2
                ) : null)),
            GestureDetector(
                onTap: (){
                  click6 = !click6;
                  setState(() {

                  });
                },
                child: colors(clr: Colors.black, brdr: click6 ? Border.all(
                    color: Colors.black,
                    width: 2
                ) : null)),
            GestureDetector(
                onTap: (){
                  click7 = !click7;
                  setState(() {

                  });
                },
                child: colors(clr: Colors.pinkAccent, brdr: click7 ? Border.all(
                    color: Colors.black,
                    width: 2
                ) : null)),
            GestureDetector(
                onTap: (){
                  click8 = !click8;
                  setState(() {

                  });
                },
                child: colors(clr: Colors.purple, brdr: click8 ? Border.all(
                    color: Colors.black,
                    width: 2
                ) : null)),
            ],
            ),
              SizedBox(
                height: 20,
              ),
            Text("Date",style: TextStyle(
                fontWeight: FontWeight.bold
            )),
              SizedBox(
                height: 10,
              ),
            TextFormField(
            readOnly: true,
            style: TextStyle(fontSize: 18),
            decoration: InputDecoration(
            hintText: Utils.toDate(fromDate),
            border: UnderlineInputBorder(
            ),
            ),
            controller: dateController,
            onTap: () => pickFromDateTime(pickDate: true),
            ),
              SizedBox(
                height: 20,
              ),
            Text("Procedure",style: TextStyle(
                fontWeight: FontWeight.bold
            )),
              SizedBox(
                height: 10,
              ),
            TextFormField(
            readOnly: true,
            style: TextStyle(fontSize: 18),
            decoration: InputDecoration(
            suffixIcon: Icon(Icons.arrow_drop_down),
            hintText: "Procedure",
            border: UnderlineInputBorder(
            ),
            ),
            ),
              SizedBox(
                height: 20,
              ),
              Text("Description",style: TextStyle(
                  fontWeight: FontWeight.bold
              ),),
              SizedBox(height: 10,),
              TextFormField(
                controller: noteController,
                maxLines: 2,
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  hintText: "Description",
                ),
              ),
              SizedBox(height: 10,),
              Center(
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      elevation: 5
                    ),
                    onPressed: () {
                    },
                    child: Text('Add Patient',style: TextStyle(
                      color: Colors.white
                    ),),
                  ),
                ),
              ),
            ]
            ,
            )
            ,
            ),
          );

        }
      ),
    );
  }
  Widget colors({
    required Color clr,
    required BoxBorder? brdr,
})=> Container(
      decoration: BoxDecoration(
        border: brdr,
        color: clr,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0),
            blurRadius: 6.0
          )
        ]
      ),
      width: 30,
      height: 30,
    )
;
  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);
    if(date == null) return;
    setState(() {
      fromDate = date;
    });
  }
  Future <DateTime?> pickDateTime(
      DateTime initialDate, {
        required bool pickDate,
        DateTime? firstDate,
      }) async {
    if(pickDate){
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime(2015, 8),
        lastDate: DateTime(2101),
      );
      if(date == null) return null;
      final time = Duration(hours: initialDate.hour, minutes: initialDate.minute);
      return date.add(time);
    } else{
      final timeOfDay = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(initialDate));
      if(timeOfDay == null) return null;
      final date = DateTime(initialDate.year, initialDate.month,initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      return date.add(time);
    }
  }
}

