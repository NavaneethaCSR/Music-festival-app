import 'package:flutter/material.dart';

const Color kLightGreen = Color.fromARGB(255, 218, 255, 123);
hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF$hexColor";
  }
  return Color(int.parse(hexColor, radix: 16));
}
