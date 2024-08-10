// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:beat_bash/screens/datetime.dart';
import 'package:beat_bash/screens/generate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserEventDetails extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> documentSnapshot;

  const UserEventDetails({
    super.key,
    required this.documentSnapshot,
  });

  @override
  State<UserEventDetails> createState() => _UserEventDetailsState();
}

class _UserEventDetailsState extends State<UserEventDetails> {
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
      backgroundColor:
          const Color.fromARGB(255, 165, 28, 108), // Set background color here
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
                      eventData['location'] ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _launchMapsUrl(eventData['location']);
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.map_outlined,
                            size: 18,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            'Open in Maps',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
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
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => First(
                          documentSnapshot: widget.documentSnapshot,
                          eventData: widget.documentSnapshot.data() ??
                              {}, // Pass the actual event data from the documentSnapshot
                          location: eventData['location'] ??
                              'Location Not Available', // Use eventData from widget
                          dateTime: eventData['dateTime'] ??
                              'Date & Time Not Available', // Use eventData from widget
                          name: eventData['name'] ??
                              'Event Name Not Available', // Use eventData from widget
                        ),
                      ),
                    );
                  },
                  child: const Text('Book Now'),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Guests:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  eventData['guests'] ?? 'No guests yet',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Sponsors:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  eventData['sponsers'] ?? 'No sponsors yet',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchMapsUrl(String? location) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$location';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
