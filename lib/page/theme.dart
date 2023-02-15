import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Themes {
  static final light = ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.redAccent[500],
      bottomNavigationBarTheme:
          BottomNavigationBarThemeData(backgroundColor: Colors.redAccent[500]));

  static final dark = ThemeData(
      primaryColor: const Color(0xff121212), brightness: Brightness.dark);
}

TextStyle get subHeadingStyle {
  return const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
}

TextStyle get titleStyle {
  return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode ? Colors.white : Colors.black);
}

TextStyle get subtitleStyle {
  return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode ? Colors.grey[100] : Colors.black54);
}
