import 'package:flutter/material.dart';
import 'package:g5_mb_campus_cleaner/src/features/dashboard/dashboard.dart';

class CampusNavigationBar {
  static BottomNavigationBar buildNav(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.verified_user),
          label: 'Open Dialog',
        ),
      ],
      onTap: (int index) {
        switch (index) {
          case 0:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const DashboardPage()));
          case 1:
        }
      },
    );
  }
}
