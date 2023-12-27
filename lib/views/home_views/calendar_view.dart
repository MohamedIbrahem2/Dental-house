import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_house/provider/event_provider.dart';
import 'package:dental_house/views/editing/event_editing_page.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';
import 'package:dental_house/models/meeting.dart';

import '../editing/TasksWidget.dart';
class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  TextEditingController name = TextEditingController();
  TextEditingController time = TextEditingController();
  late Meeting event;

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const EventEditing()));
        },
        child: const Icon(Icons.add),
      ),
      body:
      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Events').snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            final eventDocument = snapshot.data!.docs;
            events.clear();
            for(var e in eventDocument){
              final eventName = e.get("eventName");
              final description = e.get("description");
              final from = e.get("fromDate").toDate();
              final to = e.get("toDate").toDate();
              final isAllDay = e.get("allDay");
              final eventId = e.get("eventId");

              event = Meeting(eventName,
                  description,
                  from,
                  to,
                  isAllDay,
                  eventId);
              events.add(event);
            }

            return SafeArea(
              child: SfCalendar(
                view: CalendarView.month,
                firstDayOfWeek: 6,
                initialSelectedDate: DateTime.now(),
                dataSource: MeetingDataSource(events),
                monthViewSettings: const MonthViewSettings(
                    appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                    showAgenda: true
                ),
                onLongPress: (details) {
                  final provider = Provider.of<EventProvider>(
                      context, listen: false);
                  provider.setDate(details.date!);
                  showModalBottomSheet(
                    context: (context),
                    builder: (context) => TasksWidget(),
                  );
                },
              ),
            );
          }
          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator());
          }
          return Container();
        }
      ) 
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
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }
  @override
  String getId(int index) {
    return _getMeetingData(index).eventId;
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



