import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

FirebaseFirestore databases = FirebaseFirestore.instance;

final logger = Logger();
Future<void> createEvent(
    String name,
    String desc,
    String imageUrl,
    String location,
    String dateTime,
    String createdBy,
    bool isInPersonOrNot,
    String guest,
    String sponsers) async {
  try {
    await FirebaseFirestore.instance.collection('EVENTSS').add(
      {
        "name": name,
        "description": desc,
        "imageUrl": imageUrl,
        "location": location,
        "dateTime": dateTime,
        "createdBy": createdBy,
        "isInPerson": isInPersonOrNot,
        "guests": guest,
        "sponsers": sponsers
      },
    );
    logger.i("Event Created");
  } catch (e) {
    logger.e("Error creating event: $e");
  }
}

Future<List<DocumentSnapshot>> getAllEvents() async {
  try {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('EVENTSS').get();
    return querySnapshot.docs;
  } catch (e) {
    logger.e("Error fetching events: $e");
    return []; // Return an empty list in case of an error
  }
}
