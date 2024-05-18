import 'package:flutter/material.dart';
import 'package:g5_mb_campus_cleaner/src/features/detail_report/detail_report_form.dart';

class UserCampusNavigationBar {
  static BottomNavigationBar buildNav(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.airplane_ticket),
          label: 'Mis reportes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notificaciones',
        ),
      ],
      onTap: (int index) {
        switch (index) {
          case 0:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DetailReportForm()));
          case 1:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DetailReportForm()));
          case 2:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DetailReportForm()));
        }
      },
    );
  }
}
