
import 'package:dental_house/provider/event_provider.dart';
import 'package:dental_house/views/editing/Utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../home_views/calendar_view.dart';
import 'event_editing_page.dart';
class EventViewingPage extends StatelessWidget {
final Meeting event;

const EventViewingPage({
  Key? key,
  required this.event,

}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        actions: buildViewingActions(context, event),
      ),
      body: ListView(
        padding: EdgeInsets.all(32),
        children: <Widget>[
          Text(
            event.eventName,
            style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32,),
          buildDateTime(event),
          const SizedBox(height: 24,),
          const Text("Description",style: TextStyle(color: Colors.black,fontSize: 24),),
          const SizedBox(height: 10,),
          Text(event.description,
            style: TextStyle(color: Colors.black,fontSize: 18),
          )
        ],
      ),
    );

  }
Widget buildDateTime(Meeting event){
    return Column(
      children: [
        buildDate(event.isAllDay ? 'All-day' : 'From', event.from),
        SizedBox(height: 20,),
        if (!event.isAllDay) buildDate('To', event.to)
      ],
    );
}
Widget buildDate(String title, DateTime date){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
          style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
        ),
        Text(Utils.toDate(date) + " " + Utils.toTime(date)),
      ],
    );

}
List<Widget> buildViewingActions(BuildContext context, Meeting event) =>
    [
IconButton(
onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> EventEditing(event: event))),
icon: Icon(Icons.edit),
),
IconButton(onPressed: (){
final provider = Provider.of<EventProvider>(context,listen: false);
provider.deleteEvent(event);
Navigator.of(context).pop();
}, icon: Icon(Icons.delete)),
    ];
}
