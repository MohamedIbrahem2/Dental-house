import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_house/provider/event_provider.dart';
import 'package:dental_house/views/Patients_Info_views/dental_chart.dart';
import 'package:dental_house/views/home_views/procedure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/pData.dart';
import '../editing/Utils.dart';

class AddDentalNotes extends StatefulWidget {
  final MyData myList;
  const AddDentalNotes({Key? key,
    required this.myList,
  }) : super(key: key);

  @override
  State<AddDentalNotes> createState() => _AddDentalNotesState();
}

class _AddDentalNotesState extends State<AddDentalNotes> {
  var currentFocus;
  unFocus() {
    currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
  CollectionReference users = FirebaseFirestore.instance.collection('Dental House');
  Future<void> addUser(String toothNumber , Color clr,String procedure) {
    return users
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('patients')
        .doc(widget.myList.id)
        .collection('dentalNotes')
        .doc(toothNumber)
        .set({
      'toothNumber': toothNumber,
      'color': clr.toString(),
      'date': Utils.toDate(fromDate),
      'procedure': procedure,
      'note' : noteController.text,
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
  TextEditingController dateController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int showBorder = 0;
  List<Color> availableColors = [
    Colors.yellow,
    Colors.red,
    Colors.green,
    Colors.brown,
    Colors.orange,
    Colors.black,
    Colors.pink,
    Colors.purple
  ];
  var tileColor;

  late DateTime fromDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: unFocus,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: const Text(
            "Add Dental Notes",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Consumer<EventProvider>(builder: (context, model, child) {
          final provider = Provider.of<EventProvider>(context);
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Tooth Number",
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
                              child: Center(
                                  child: Text(
                                model.selectedTeethPart[index],
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Choose a color",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: SizedBox(
                        height: 30,
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: availableColors.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (availableColors[index] == Colors.yellow) {
                              tileColor = Colors.yellow;
                            }
                            if (availableColors[index] == Colors.red) {
                              tileColor = Colors.red;
                            }
                            if (availableColors[index] == Colors.green) {
                              tileColor = Colors.green;
                            }
                            if (availableColors[index] == Colors.brown) {
                              tileColor = Colors.brown;
                            }
                            if (availableColors[index] == Colors.orange) {
                              tileColor = Colors.orange;
                            }
                            if (availableColors[index] == Colors.black) {
                              tileColor = Colors.black;
                            }
                            if (availableColors[index] == Colors.pink) {
                              tileColor = Colors.pink;
                            }
                            if (availableColors[index] == Colors.purple) {
                              tileColor = Colors.purple;
                            }
                            return Padding(
                              padding: const EdgeInsets.only(left: 9),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    showBorder = index;
                                    provider.tileColor = availableColors[index];
                                  });
                                },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      color: tileColor,
                                      border: showBorder == index
                                          ? Border.all(
                                              color: Colors.blueAccent, width: 3)
                                          : Border(),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(0.0, 1.0),
                                            blurRadius: 6.0)
                                      ]),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Date", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      readOnly: true,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: Utils.toDate(fromDate),
                        border: UnderlineInputBorder(),
                      ),
                      controller: dateController,
                      onTap: () => pickFromDateTime(pickDate: true),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Procedure",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (val){
                        if(provider.lines.isEmpty){
                          return "Procedure Can't be Empty";
                        }
                      },
                      initialValue: provider.lines.isNotEmpty ? provider.lines.toString() : null,
                      readOnly: true,
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  Procedure(myList: widget.myList,)));
                      },
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.arrow_drop_down),
                        hintText: "Procedure",
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Notes",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: noteController,
                      maxLines: 2,
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        hintText: "Add Notes",
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent, elevation: 5),
                          onPressed: ()async{
                            if(_formKey.currentState!.validate()){
                              await addUser(model.selectedTeethPart.length == 1 ? model.selectedTeethPart.first : model.selectedTeethPart.toString(), model.tileColor, model.lines.toString());
                              model.addTeeth();
                              Navigator.pop(context);
                            }

                            },
                          child: Text(
                            'Save',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);
    if (date == null) return;
    setState(() {
      fromDate = date;
    });
  }

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime(2015, 8),
        lastDate: DateTime(2101),
      );
      if (date == null) return null;
      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);
      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
          context: context, initialTime: TimeOfDay.fromDateTime(initialDate));
      if (timeOfDay == null) return null;
      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      return date.add(time);
    }
  }
}
