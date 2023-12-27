import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_house/views/home_views/calendar_view.dart';
import 'package:uuid/uuid.dart';

import '../models/meeting.dart';
class FireStoreService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> saveEvent(Meeting meeting) {
    return firestore
        .collection("Events")
        .doc(meeting.eventId)
        .set(meeting.createMap());
  }
  Future<void> removeEvent(String productId) {
    return firestore.collection('Events').doc(productId).delete();
  }
  Future<void> editEvent(String productId , Meeting meeting){
    return firestore
        .collection('Events')
        .doc(productId)
        .update(meeting.createMap());
  }
  Future<void> deleteData(String documentId) async {
    await firestore.doc(documentId).delete();
  }

}