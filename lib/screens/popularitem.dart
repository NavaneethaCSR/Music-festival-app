import 'package:beat_bash/screens/eventdetails.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:beat_bash/screens/datetime.dart';

class PopularItem extends StatelessWidget {
  final int index;
  final DocumentSnapshot<Map<String, dynamic>> eventData;

  const PopularItem({
    super.key,
    required this.index,
    required this.eventData,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EventDetails(documentSnapshot: eventData),
        ),
      ),
      minLeadingWidth: 0,
      minVerticalPadding: 10,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Text(
        "$index.",
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
      title: Text(
        eventData.data()?["name"],
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
      subtitle: Column(
        children: [
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.calendar_month_outlined,
                  size: 18, color: Colors.white),
              const SizedBox(width: 4),
              Text(
                formatDate(eventData.data()?["datetime"]),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 14),
              const Icon(Icons.access_time_rounded,
                  size: 18, color: Colors.white),
              const SizedBox(width: 4),
              Text(
                formatTime(eventData.data()?["datetime"]),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.location_on_outlined,
                  size: 18, color: Colors.white),
              const SizedBox(width: 4),
              Text(
                eventData.data()?["location"],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                eventData['guests'] ?? '',
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                eventData['sponsers'] ?? '',
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ],
      ),
      textColor: Colors.white,
    );
  }
}
