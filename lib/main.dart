import 'package:flutter/material.dart';
import 'package:g5_mb_campus_cleaner/src/login/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
