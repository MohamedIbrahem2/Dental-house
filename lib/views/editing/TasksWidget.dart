import 'package:dental_house/provider/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import '../home_views/calendar_view.dart';
import 'EventViewingPage.dart';
class TasksWidget extends StatefulWidget {

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    final selectedEvents = provider.eventsOfSelectedDate;
    if(selectedEvents.isEmpty) {
      return Center(
        child: Text('No Event Found',
          style: TextStyle(color: Colors.black,fontSize: 24),
        ),
      );
    }
    return SfCalendarTheme(
      data: SfCalendarThemeData(
        timeTextStyle: TextStyle(fontSize: 16, color: Colors.blue)
      ),
      child: SfCalendar(
        view: CalendarView.timelineDay,
        dataSource: MeetingDataSource(provider.events),
        initialDisplayDate: provider.selectedDate,
        onTap: (details){
          if(details.appointments == null) return;
          final event = details.appointments?.first;
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> EventViewingPage(event: event),
          )
          );
        },
        headerHeight: 0,
        todayHighlightColor: Colors.blue,
        selectionDecoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.3)
        ),
      )
    );
  }
  Widget appointmentBuilder(
      BuildContext context,
      CalendarAppointmentDetails details,
      ){
    final event = details.appointments.first;
    return Container(
      width: details.bounds.width,
      height: details.bounds.height,
      decoration: BoxDecoration(
        color: event.backgroundColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12)
      ),
      child: Center(
        child: Text(
          event.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.blue,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        ),
        ),
      ),
    );
  }
}
