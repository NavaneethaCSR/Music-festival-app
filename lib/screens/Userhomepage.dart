// ignore_for_file: use_key_in_widget_constructors, prefer_typing_uninitialized_variables, must_be_immutable, avoid_print, unused_element

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:beat_bash/screens/Usereventcontainer.dart';
import 'package:beat_bash/screens/Usereventdetails.dart';

import 'package:beat_bash/screens/profile.dart';

class Userhomepage extends StatefulWidget {
  var userType;

  Userhomepage({required Key key, @required this.userType}) : super(key: key);

  @override
  State<Userhomepage> createState() => UserhomepageState();
}

class UserhomepageState extends State<Userhomepage> {
  String username = "";
  List<DocumentSnapshot<Map<String, dynamic>>> events = [];
  @override
  void initState() {
    super.initState();

    initializeUserData();
  }

  Future<void> initializeUserData() async {
    await getUserData();
    refresh();
  }

  void registerUser(String email, String password, String displayName) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Set the display name for the newly registered user
      await userCredential.user!.updateDisplayName(displayName);

      // Now the displayName will be available for the user
    } catch (e) {
      print("Failed to register user: $e");
    }
  }

  Future<void> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload(); // Refresh user data to ensure displayName is updated
      user = FirebaseAuth.instance.currentUser;
      setState(() {
        username = user!.displayName ?? "";
      });
    }
  }

  Future<void> refresh() async {
    QuerySnapshot<Map<String, dynamic>> fetchedEvents =
        await FirebaseFirestore.instance.collection('EVENTSS').get();
    setState(() {
      events = fetchedEvents.docs;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 165, 28, 108),
        foregroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Profile()),
              );
              refresh();
            },
            icon: const Icon(
              Icons.account_circle,
              size: 30,
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hi $username 👋",
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Text(
                    "Explore events around you",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  events.isEmpty
                      ? const SizedBox()
                      : CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 5),
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.99,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                          ),
                          items: events
                              .asMap()
                              .entries
                              .map((entry) => UserEventContainer(
                                    data: events[entry.key],
                                    documentSnapshot: events[entry.key],
                                  ))
                              .toList(),
                        ),
                  const SizedBox(height: 16),
                  const Text(
                    "Popular Events ",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return UserEventContainer(
                  data: events[index],
                  documentSnapshot: events[index],
                );
              },
              childCount: events.length,
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(bottom: 2, top: 8, left: 6, right: 6),
              child: Text(
                "All Events",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserEventDetails(
                        documentSnapshot: events[index],
                        // Pass the username here
                      ),
                    ),
                  );
                },
                child: UserEventContainer(
                  data: events[index],
                  documentSnapshot: events[index],
                ),
              ),
              childCount: events.length,
            ),
          ),
        ],
      ),
    );
  }
}
