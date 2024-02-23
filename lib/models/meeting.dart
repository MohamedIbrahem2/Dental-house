

class Meeting{
  Meeting(this.eventName,this.description, this.from, this.to,this.isAllDay,this.eventId);
  String eventId;
  String eventName;
  String description;
  DateTime from;
  DateTime to;
  bool isAllDay;
  Map<String , dynamic> createMap(){
    return{
      'eventName' : eventName,
      'description' : description,
      'fromDate' : from,
      'toDate' : to,
      'allDay' : isAllDay,
      'eventId' : eventId,
    };
  }
  Meeting.fromFireStore(Map<String,dynamic> fireStoreMap):
        eventName = fireStoreMap['eventName'],
        description = fireStoreMap['description'],
        from = fireStoreMap['fromDate'],
        to = fireStoreMap['toDate'],
        isAllDay = fireStoreMap['allDay'],
        eventId = fireStoreMap['eventId'];
}