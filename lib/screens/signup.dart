// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:beat_bash/reusable_widgets/reusable_widgets.dart';
import 'package:beat_bash/screens/signin.dart';
import 'package:logger/logger.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  final logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
          255, 85, 19, 126), // Set the background color of the entire screen
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            MediaQuery.of(context).size.height * 0.2,
            20,
            0,
          ),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              reusabletextfield(
                "Enter Username",
                Icons.person_outline,
                false,
                _userNameTextController,
              ),
              const SizedBox(
                height: 20,
              ),
              reusabletextfield(
                "Enter email",
                Icons.person_outline,
                true,
                _emailTextController,
              ),
              const SizedBox(
                height: 20,
              ),
              reusabletextfield(
                "Enter Password",
                Icons.lock_outline,
                true,
                _passwordTextController,
              ),
              const SizedBox(
                height: 20,
              ),
              signinsignupbutton(context, false, () async {
                try {
                  UserCredential userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: _emailTextController.text,
                    password: _passwordTextController.text,
                  );

                  // Set display name for the user
                  await userCredential.user!
                      .updateDisplayName(_userNameTextController.text);

                  logger.i("created new account");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Signin(),
                    ),
                  );
                } catch (error) {
                  logger.e("Error $error");
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
