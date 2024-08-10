// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:beat_bash/screens/confirmlist.dart';
import 'package:beat_bash/screens/datetime.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventDetails extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> documentSnapshot;

  const EventDetails({
    Key? key,
    required this.documentSnapshot,
  }) : super(key: key);

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  late DateTime parsedDateTime;

  @override
  void initState() {
    super.initState();
    final eventData = widget.documentSnapshot.data() ?? {};
    String? dateTime = eventData['dateTime'];

    if (dateTime != null) {
      parsedDateTime = DateTime.parse(dateTime);
    } else {
      parsedDateTime = DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    final eventData = widget.documentSnapshot.data() ?? {};

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 85, 19, 126),
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 300,
                width: double.infinity,
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.3),
                    BlendMode.darken,
                  ),
                  child: Image.network(
                    eventData['imageUrl'] ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Container(
                        color: Colors.grey,
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: 25,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                bottom: 45,
                left: 8,
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_month_outlined,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      formatDate(parsedDateTime),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    const Icon(
                      Icons.access_time_outlined,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      formatTime(parsedDateTime),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 20,
                left: 8,
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      "${eventData['location']}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        eventData['name'] ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Icon(Icons.share),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  eventData['description'] ?? '',
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(
                  height: 8,
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Existing code...

                      const SizedBox(height: 8),

                      // Display guests
                      Text(
                        'Guests: ${eventData['guests'] ?? ''}',
                        style: const TextStyle(color: Colors.white),
                      ),

                      const SizedBox(height: 8),

                      // Display sponsors

                      // Existing code...
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Existing code...

                      const SizedBox(height: 8),

                      // Display guests
                      Text(
                        'Sponsors: ${eventData['sponsers'] ?? ''}',
                        style: const TextStyle(color: Colors.white),
                      ),

                      const SizedBox(height: 8),

                      // Display sponsors

                      // Existing code...
                    ],
                  ),
                ),

                // Other details...

                // Add the ElevatedButton widget here
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the ConfirmedBookingsScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ConfirmedBookingsScreen(
                          confirmedBookings: [],
                          username: '',
                        ),
                      ),
                    );
                  },
                  child: const Text('View Confirmed Bookings'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
