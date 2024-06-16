import 'package:flutter/material.dart';

class CameraButtonWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;

  const CameraButtonWidget(
      {super.key, required this.imagePath, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Image.asset(imagePath),
    );
  }
}
