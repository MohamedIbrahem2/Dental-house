import 'package:flutter/material.dart';
import 'package:dental_house/service/fire_store.dart';
import '../models/meeting.dart';
class EventProvider extends ChangeNotifier {
  final service = FireStoreService();
  final List<Meeting> _event = [];
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

}
