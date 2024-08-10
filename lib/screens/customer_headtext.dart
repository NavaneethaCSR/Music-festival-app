// ignore_for_file: unused_import

import 'package:beat_bash/screens/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomHeadText extends StatefulWidget {
  final String text;
  const CustomHeadText({super.key, required this.text});

  @override
  State<CustomHeadText> createState() => _CustomHeadTextState();
}

class _CustomHeadTextState extends State<CustomHeadText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: const TextStyle(
          color: Color.fromARGB(255, 85, 19, 126),
          fontSize: 32,
          fontWeight: FontWeight.w600),
    );
  }
}
