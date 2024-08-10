import 'package:flutter/material.dart';
import 'package:beat_bash/screens/colors.dart';
import 'package:beat_bash/screens/signin.dart';
import 'package:beat_bash/screens/usersignin.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome!!', textAlign: TextAlign.center),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("CB2B93"),
          hexStringToColor("9546C4"),
          hexStringToColor("5E61F4")
        ])), // Background color
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserSignin()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16), // Increase button size
                    ),
                    child: const Text(
                      'User Login',
                      style: TextStyle(fontSize: 20), // Increase text size
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Add some spacing
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Signin()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16), // Increase button size
                    ),
                    child: const Text(
                      'Admin Login',
                      style: TextStyle(fontSize: 20), // Increase text size
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
