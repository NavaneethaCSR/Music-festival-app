// ignore_for_file: use_super_parameters, avoid_print, unnecessary_cast, must_be_immutable, collection_methods_unrelated_type

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:beat_bash/screens/Usereventdetails.dart';

import 'datetime.dart';

class UserEventContainer extends StatelessWidget {
  final DocumentSnapshot<Map<String, dynamic>> data;
  final DocumentSnapshot<Map<String, dynamic>> documentSnapshot;

  late DateTime parsedDateTime;

  UserEventContainer({
    Key? key,
    required this.data,
    required this.documentSnapshot,
  }) : super(key: key) {
    // Initialize parsedDateTime with the value of datetime if it's not null
    Map<String, dynamic> eventData = data.data() ?? {};
    String? dateTime = eventData['dateTime'];
    if (dateTime != null) {
      print(dateTime);
      parsedDateTime = DateTime.parse(dateTime);
    } else {
      // Handle the case where datetime is null
      // For example, set parsedDateTime to the current date/time
      parsedDateTime = DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> eventData = data.data() ?? {};

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserEventDetails(
              documentSnapshot: documentSnapshot,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                    255, 165, 28, 108), // Set background color here
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 165, 28, 108),
                    blurRadius: 0,
                    offset: Offset(5, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.35),
                    BlendMode.darken,
                  ),
                  child: Image.network(
                    eventData['imageUrl'] ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Container(
                        color: Colors
                            .grey, // Placeholder color if image fails to load
                      );
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 70,
              left: 16,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  eventData['name'] ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 45,
              left: 16,
              child: Row(
                children: [
                  const Icon(Icons.calendar_month_outlined, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    formatDate(parsedDateTime),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Icon(Icons.access_time_rounded, size: 18),
                  const SizedBox(width: 4),
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
              left: 16,
              child: Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    eventData['location'] ?? '',
                    style: const TextStyle(
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
    );
  }
}
