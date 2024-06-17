import 'package:flutter/material.dart';
import 'package:g5_mb_campus_cleaner/screens/log_in_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Clean App',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const LogInPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
