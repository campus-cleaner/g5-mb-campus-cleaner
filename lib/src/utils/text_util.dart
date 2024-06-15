import 'package:flutter/material.dart';

class TextUtil {
  static Widget buildBlackText(String text, {bool centered = false}) {
    return Text(
      text,
      textAlign: centered ? TextAlign.center : TextAlign.start,
      softWrap: true,
      style: const TextStyle(
          color: Colors.black, fontFamily: 'Quicksand', fontSize: 15),
    );
  }

  static Widget buildBoldText(String text,
      {Color color = Colors.black, bool centered = false}) {
    return Text(
      text,
      textAlign: centered ? TextAlign.center : TextAlign.start,
      softWrap: true,
      style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontFamily: 'Quicksand',
          fontSize: 15),
    );
  }

  static Widget buildBigWhiteAndBoldText(String text) {
    return Text(
      text,
      softWrap: true,
      style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: 'Quicksand',
          fontSize: 40,
          letterSpacing: 2),
    );
  }

  static Widget buildRobotoTitleText(String text,
      {Color color = Colors.white}) {
    return Text(
      text,
      softWrap: true,
      style: TextStyle(
          color: color,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w900,
          fontSize: 35),
    );
  }
}
