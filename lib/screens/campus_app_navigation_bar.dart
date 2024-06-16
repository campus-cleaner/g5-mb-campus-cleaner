import 'package:flutter/material.dart';
import 'package:g5_mb_campus_cleaner/screens/user/unmsm-member/my_reports_page.dart';
import 'package:g5_mb_campus_cleaner/screens/admin/news_admin_page.dart';
import 'package:g5_mb_campus_cleaner/screens/user/unmsm-member/news_page.dart';
import 'package:g5_mb_campus_cleaner/screens/user/cleaner/pending_list_page_by_responsible.dart';
import 'package:g5_mb_campus_cleaner/screens/admin/pending_list_page.dart';
import 'package:g5_mb_campus_cleaner/screens/user/unmsm-member/welcome_page.dart';

class CampusNavigationBar {
  static BottomNavigationBar buildNav(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.newspaper),
          label: 'Noticias',
        ),
      ],
      onTap: (int index) {
        switch (index) {
          case 0:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PendingListPage()));
          case 1:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NewsAdminPage()));
        }
      },
    );
  }

  static BottomNavigationBar buildNavCleaner(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.newspaper),
          label: 'Noticias',
        ),
      ],
      onTap: (int index) {
        switch (index) {
          case 0:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PendingListResponsiblePage()));
          case 1:
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => NewsPage()));
        }
      },
    );
  }

  static BottomNavigationBar buildNavUser(BuildContext context) {
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const WelcomePage()));
          case 1:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MyReportsPage()));
          case 2:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const NewsPage()));
        }
      },
    );
  }
}
