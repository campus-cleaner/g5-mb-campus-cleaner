import 'package:flutter/material.dart';
import 'package:g5_mb_campus_cleaner/utils/login_background_painter_util.dart';

class LoginBackgroundWidget extends StatelessWidget {
  final Widget child;

  const LoginBackgroundWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LoginBackgroundPainterUtil(),
      child: child,
    );
  }
}
