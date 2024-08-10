// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

Future<void> fetchData() async {
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('EVENTSS').get();

    // Loop through the documents in the query snapshot
    for (var doc in querySnapshot.docs) {
      // Access the document ID using the 'id' property
      String documentId = doc.id;
      print('Document ID: $documentId');

      // Retrieve the datetime string from the document data
      String? dateTimeString = doc.data()['dateTime'];

      if (dateTimeString != null) {
        // Parse the string into a DateTime object
        DateTime dateTime = DateTime.parse(dateTimeString);

        print('Formatted Date: ${formatDate(dateTime)}');
        print('Formatted Time: ${formatTime(dateTime)}');
      } else {
        print('DateTime string is null or not found in document: $documentId');
      }
    }
  } catch (error) {
    print('Error fetching documents: $error');
  }
}

String formatTime(DateTime dateTime) {
  return DateFormat.jm().format(dateTime);
}

String formatDate(DateTime dateTime) {
  return DateFormat('MMM dd, yyyy').format(dateTime);
}
