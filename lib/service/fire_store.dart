import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_house/views/home_views/calendar_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../models/meeting.dart';
class FireStoreService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveEvent(Meeting meeting) {
    return firestore
        .collection('Dental House')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('events')
        .doc(meeting.eventId)
        .set(meeting.createMap());
  }
  Future<void> removeEvent(String productId) {
    return firestore.collection('Dental House')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('events')
        .doc(productId)
        .delete();
  }
  Future<void> editEvent(String productId , Meeting meeting){
    return firestore
        .collection('Dental House')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('events')
        .doc(productId)
        .update(meeting.createMap());
  }
  Future<void> deleteData(String documentId) async {
    await firestore
        .collection('Dental House')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('events')
        .doc(documentId).delete();
  }


}