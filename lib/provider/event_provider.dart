import 'package:flutter/material.dart';

import '../views/home_views/calendar_view.dart';
class EventProvider extends ChangeNotifier {
  final List<Meeting> _event = [];
  List<Meeting> get events => _event;

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) => _selectedDate = date;

  List<Meeting> get eventsOfSelectedDate => _event;


  void addEvent(Meeting event) {
    _event.add(event);
    notifyListeners();
  }
  void editEvent(Meeting newEvent, Meeting oldEvent){
    final index = _event.indexOf(oldEvent);
    _event[index] = newEvent;
    notifyListeners();
  }
  void deleteEvent(Meeting event){
    _event.remove(event);
    notifyListeners();
  }
}