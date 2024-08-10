import 'package:flutter/material.dart';

class ConfirmedBookingsScreen extends StatelessWidget {
  final List<String> confirmedBookings;
  final String username;

  // ignore: use_super_parameters
  const ConfirmedBookingsScreen({
    Key? key,
    required this.confirmedBookings,
    required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$username\'Confirmed Bookings'),
      ),
      body: ListView.builder(
        itemCount: confirmedBookings.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(confirmedBookings[index]),
          );
        },
      ),
    );
  }
}
