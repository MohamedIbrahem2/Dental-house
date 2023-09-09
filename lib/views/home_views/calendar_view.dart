import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dental_house/provider/event_provider.dart';
import 'package:dental_house/views/editing/event_editing_page.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../editing/TasksWidget.dart';
class calendar extends StatefulWidget {
  @override
  State<calendar> createState() => _calendarState();
}

class _calendarState extends State<calendar> {
  TextEditingController name = TextEditingController();
  TextEditingController time = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> EventEditing()));
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: SfCalendar(
          view: CalendarView.month,
          firstDayOfWeek: 6,
          initialSelectedDate: DateTime.now(),
          dataSource: MeetingDataSource(events),
          monthViewSettings: MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
            showAgenda: true
          ),
          onLongPress: (details){
            final provider = Provider.of<EventProvider>(context, listen: false);
            provider.setDate(details.date!);
            showModalBottomSheet(
                context: (context),
                builder: (context) => TasksWidget(),
            );
          },
        ),
      ),

    );
  }


}
class MeetingDataSource extends CalendarDataSource{
  MeetingDataSource(List<Meeting> source){
    appointments = source;
  }
  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

class Meeting {
  Meeting(this.eventName,this.description, this.from,this.background, this.to,this.isAllDay);

  String eventName;
  String description;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

