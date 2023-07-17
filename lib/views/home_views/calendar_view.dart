import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';
String? appoin;
int? tme;
bool event = true;
class calendar extends StatefulWidget {


  @override
  State<calendar> createState() => _calendarState();
}

class _calendarState extends State<calendar> {
  TextEditingController name = TextEditingController();
  TextEditingController time = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          AwesomeDialog(
            borderSide: BorderSide(
                width: 3,
                color: Colors.blue
            ),
            context: context,
            title: "Error",
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent)
                      ),
                      hintText: "Type Name",
                      labelText: "Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextFormField(
                    controller: time,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent)
                      ),
                      hintText: "Type Name",
                      labelText: "Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  TextButton(
                      onPressed: (){
                         appoin = name.text;
                         tme = int.parse(time.text);
                          event = false;
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>calendar()));

                      },
                      child: Text("ADD")
                  )
                ],
              ),
            ),
          ).show();
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        child: SafeArea(
          child: SfCalendar(
            view: CalendarView.day,
            firstDayOfWeek: 6,
            dataSource: event == false ? MeetingDataSource(_getDataSource()) : null,
            monthViewSettings: MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
          ),
        ),
      ),

    );
  }

}
List<Meeting> _getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
  DateTime(today.year, today.month, today.day, tme!, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));
  meetings.add(Meeting(
      appoin!, startTime, endTime, const Color(0xFF0F8644), false));
  return meetings;

}


class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

