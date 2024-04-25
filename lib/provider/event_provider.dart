import 'package:dental_house/models/pData.dart';
import 'package:dental_house/models/procedureModel.dart';
import 'package:dental_house/models/teeth_part.dart';
import 'package:dental_house/models/tooth_color.dart';
import 'package:flutter/material.dart';
import 'package:dental_house/service/fire_store.dart';
import 'package:flutter/services.dart';
import '../models/meeting.dart';
import 'package:xml/xml.dart';
class EventProvider extends ChangeNotifier {
  final service = FireStoreService();
  var myCanvas ;
  int i = 0;
  var paint;
  var paint2;
  var documents;
  String photo = '';
  String lastName = '';
  String name = '';
  final List<MyColor> toothClr  = [];
   Color tileColor = Colors.yellow;
  bool clicked = true;
  late List<bool> ischecked  = List<bool>.filled(documents.length, false);

  final List<MyProcedure> procedure = [];
  final List lines = [];
  List<String> selectedTeethPart = [];
  List<String> selectedTeethNote = [];
  final List<Meeting> _event = [];
  final List<MyData> _list = [];
  List<MyData> get lists => _list;
  int selectedPage = 2;
  List<Meeting> get events => _event;
  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) => _selectedDate = date;

  List<Meeting> get eventsOfSelectedDate => _event;


  void editEvent(Meeting newEvent, Meeting oldEvent) {
    final index = _event.indexOf(oldEvent);
    _event[index] = newEvent;
    service.editEvent(oldEvent.eventId, newEvent);
    notifyListeners();
  }

  void deleteEvent(Meeting event) {
    service.removeEvent(event.eventId);
    _event.remove(event);
    notifyListeners();
    print("event deleted");
  }

  void saveEvent(Meeting event) {
    var newEvent = event;
    service.saveEvent(newEvent);
    notifyListeners();
  }
  changePage(int i){
    selectedPage = i;
    notifyListeners();
  }
  MyData getSelectedItem(int index) {
    return _list[index];
  }
  final List<GeneralBodyPart> teethPart = [];
  Future<void> loadSvgImage({required String svgImage}) async {
    String generalString = await rootBundle.loadString(svgImage);
    teethPart.clear();
    XmlDocument document = XmlDocument.parse(generalString);

    final paths = document.findAllElements('path');

    for (var element in paths) {

      String partName = element.getAttribute('id').toString();
      String partPath = element.getAttribute('d').toString();

      if (!partName.contains('path')) {
        GeneralBodyPart part = GeneralBodyPart(name: partName, path: partPath);
        teethPart.add(part);

      }

    }
    notifyListeners();
  }
  void selectTeethPart(String name){
    if(selectedTeethPart.contains(name)){
      selectedTeethPart.remove(name);
    }else{
      selectedTeethPart.add(name);
    }
    if(selectedTeethPart.isNotEmpty){
      clicked = false;
    }else{
      clicked = true;
    }


    print(name);
    notifyListeners();
  }
  void addPro(){
    ischecked = List<bool>.filled(documents.length, false);
    notifyListeners();
  }
  void addTeeth(){
    selectedTeethNote.addAll(selectedTeethPart);
    selectedTeethPart.clear();
    i = toothClr.length;
    clicked = true;
    notifyListeners();
  }
  void addPro1(String teeth, Color clr){
    selectedTeethNote.add(teeth);
    toothClr.add(MyColor(name: teeth, clr: clr));
    i = toothClr.length;
    notifyListeners();
  }
}


