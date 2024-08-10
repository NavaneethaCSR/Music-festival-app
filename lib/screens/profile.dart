import 'package:beat_bash/screens/signin.dart';
import 'package:beat_bash/screens/colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:beat_bash/screens/signup.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = "";
  String email = "";

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      setState(() {
        name = user.displayName ?? ""; // Get user's display name
        email = user.email ?? ""; // Get user's email
      });
    }
  }

  // Widget build() method and other code remains the same...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      color: kLightGreen,
                      fontWeight: FontWeight.w800,
                      fontSize: 24),
                ),
                Text(
                  email,
                  style: const TextStyle(
                      color: kLightGreen,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  ListTile(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => rsvpEvents())),
                    title: const Text(
                      "RSVP Events",
                      style: TextStyle(color: kLightGreen),
                    ),
                  ),
                  ListTile(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => manageEvents())),
                    title: const Text(
                      "Manage Events",
                      style: TextStyle(color: kLightGreen),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      const Signup();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Signin()));
                    },
                    title: const Text(
                      "Logout",
                      style: TextStyle(color: kLightGreen),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  rsvpEvents() {}

  manageEvents() {}
}
