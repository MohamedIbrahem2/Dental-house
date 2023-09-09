
import 'package:dental_house/views/home_views/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/event_provider.dart';
import 'Utils.dart';
class EventEditing extends StatefulWidget {
  final Meeting? event;

  const EventEditing({
    Key? key,
    this.event,
}) : super(key: key);
  @override
  State<EventEditing> createState() => _EventEditingState();
}

class _EventEditingState extends State<EventEditing> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;
  @override
  void initState(){
    super.initState();
    if(widget.event == null){
      fromDate = DateTime.now();
      toDate = DateTime.now().add(Duration(hours: 2));
    } else{
      final event = widget.event!;
      titleController.text = event.eventName;
      fromDate = event.from;
      toDate = event.to;
    }
  }
  @override
  void dispose(){
    titleController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      leading: CloseButton(),
      actions: buildEditingActions(),
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(12),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
              buildTitle(),
            SizedBox(height: 12,),
            buildDateTimePacker(),
          ],
        ),
      ),
    ),
  );
  List<Widget> buildEditingActions() =>[
    ElevatedButton.icon(
        onPressed: saveForm,
        icon: Icon(Icons.done),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        label: Text("Save")
    ),
  ];
  Widget buildTitle() => TextFormField(
    style: TextStyle(fontSize: 24),
    decoration: InputDecoration(
      border: UnderlineInputBorder(),
      hintText: "Add Title",
    ),
    onFieldSubmitted: (_) => saveForm(),
    validator: (title) =>
    title != null && title.isEmpty ? "Title Cannot Be Empty" : null,
    controller: titleController,
  );
  Widget buildDateTimePacker() => Column(
    children: [
      buildFrom(),
      buildTo(),
    ],
  );
  Widget buildFrom() => buildHeader(
    header: 'From',
    child: Row(
      children: [
        Expanded(
          flex: 2,
            child: buildDropDownField(
                text: Utils.toDate(fromDate),
                onClicked: () => pickFromDateTime(pickDate: true),
            )),
        Expanded(
            child: buildDropDownField(
              text: Utils.toTime(fromDate),
              onClicked: () => pickFromDateTime(pickDate: false),
            ),
        )
      ],
    ),
  );
  Widget buildTo() => buildHeader(
    header: 'To',
    child: Row(
      children: [
        Expanded(
            flex: 2,
            child: buildDropDownField(
                text: Utils.toDate(toDate),
                onClicked: () => pickToDateTime(pickDate: true)
            )),
        Expanded(
          child: buildDropDownField(
            text: Utils.toTime(toDate),
            onClicked: () => pickToDateTime(pickDate: false),
          ),
        )
      ],
    ),
  );
  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);
    if(date == null) return;
    if(date.isAfter(toDate)){
      toDate = DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }
    setState(() {
      fromDate = date;
    });
  }
  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(
        toDate,
        pickDate: pickDate,
      firstDate: pickDate ? fromDate : null,
    );

    if(date == null) return;
    if(date.isAfter(toDate)){
      toDate = DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }
    setState(() {
      toDate = date;
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
  Widget buildDropDownField({
    required String text,
    required VoidCallback onClicked,
}) =>
      ListTile(
        title: Text(text),
        trailing: Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );
  Widget buildHeader({
    required String header,
    required Widget child,
}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(header,style: TextStyle(fontWeight: FontWeight.bold),),
          child,
        ],
      );
  Future saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if(isValid){
      final event = Meeting(
          titleController.text,
          'Description',
          fromDate,
          Colors.blue,
          toDate,
          false
      );
      final isEditing = widget.event != null;
      final provider = Provider.of<EventProvider>(context, listen: false);
      if(isEditing){
        provider.editEvent(event, widget.event!);
      }else{
        provider.addEvent(event);
      }
      Navigator.of(context).pop();
    }
  }
}

