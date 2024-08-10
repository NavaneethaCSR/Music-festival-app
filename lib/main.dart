// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:beat_bash/screens/LoginScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseOptions firebaseOptions = const FirebaseOptions(
    apiKey: 'AIzaSyBGsa4HIaWunfY9MV7UsuP-G8V9wBLdqDg',
    projectId: 'signin-example-5b2f0',
    storageBucket: 'signin-example-5b2f0.appspot.com',
    messagingSenderId: '327807637773',
    appId: '1:327807637773:android:3d7178d728d9d57bcff844',
  );

  await Firebase.initializeApp(
    options: firebaseOptions,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // root of the app
  @override
  Widget build(BuildContext context) {
    //material- android app
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.indigo,
        ),
        home: LoginScreen());
  }
}

class HomeScreen1 extends StatelessWidget {
  const HomeScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    //scaffold is a screen to display
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(),
    );
  }
}
