import 'package:flutter/material.dart';

class ButtonUtil {
  static ButtonStyle buildGreenButton() {
    return ElevatedButton.styleFrom(
      shape: const StadiumBorder(),
      elevation: 20,
      backgroundColor: const Color.fromARGB(255, 31, 172, 90),
      minimumSize: const Size.fromHeight(60),
    );
  }
}
