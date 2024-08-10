import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:logger/logger.dart';

import 'package:beat_bash/reusable_widgets/reusable_widgets.dart';
import 'package:beat_bash/screens/Userhomepage.dart';

import 'package:beat_bash/screens/usersignup.dart';

class UserSignin extends StatefulWidget {
  const UserSignin({super.key});

  @override
  State<UserSignin> createState() => _UserSigninState();
}

class _UserSigninState extends State<UserSignin> {
  final logger = Logger();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _usernameTextController = TextEditingController();
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
          255, 165, 28, 108), // Set background color to blue
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.2, 20, 0),
          child: Column(
            children: <Widget>[
              logoWidget("assets/images/beat bash.jpeg"),
              const SizedBox(
                height: 30,
              ),
              reusabletextfield("Enter Email", Icons.person_outline, false,
                  _usernameTextController),
              const SizedBox(
                height: 20,
              ),
              reusabletextfield("Enter Password", Icons.lock_outline, true,
                  _passwordTextController),
              const SizedBox(
                height: 20,
              ),
              signinsignupbutton(context, true, () {
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: _usernameTextController.text,
                        password: _passwordTextController.text)
                    .then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Userhomepage(key: UniqueKey(), userType: 'admin'),
                      ));
                }).onError((error, stackTrace) {
                  logger.e("Error ${error.toString()}");
                });
              }),
              signupOption()
            ],
          ),
        ),
      ),
    );
  }

  Row signupOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const UserSignup()));
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget logoWidget(String imagePath) {
    return Image.asset(
      imagePath,
      // Add any additional properties to customize the image widget
    );
  }
}
