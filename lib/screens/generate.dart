import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class First extends StatelessWidget {
  const First({
    super.key,
    required this.documentSnapshot,
    required this.eventData,
    required this.location,
    required this.dateTime,
    required this.name,
  });

  final DocumentSnapshot<Map<String, dynamic>> documentSnapshot;
  final Map<String, dynamic> eventData;
  final String location;
  final String dateTime;
  final String name;

  @override
  Widget build(BuildContext context) {
    final String eventDetails =
        'Name: $name\nLocation: $location\nDate&Time: $dateTime';

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: BarcodeWidget(
                barcode: Barcode.qrCode(),
                data: eventDetails,
                width: 200,
                height: 200,
              ),
            ),
            // Display event details using the provided data
            Text(
              'Event Name: $name',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Location: $location',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Date&Time: $dateTime',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Display QR code representing event details
          ],
        ),
      ),
    );
  }
}
