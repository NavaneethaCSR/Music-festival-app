// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:beat_bash/reusable_widgets/reusable_widgets.dart';

import 'package:logger/logger.dart';
import 'package:beat_bash/screens/usersignin.dart';

class UserSignup extends StatefulWidget {
  const UserSignup({super.key});

  @override
  State<UserSignup> createState() => _UserSignupState();
}

class _UserSignupState extends State<UserSignup> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _usernameTextController = TextEditingController();
  final logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
          255, 165, 28, 108), // Set the background color of the entire screen
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
                _usernameTextController,
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
                      .updateDisplayName(_usernameTextController.text);

                  logger.i("created new account");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserSignin(),
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
