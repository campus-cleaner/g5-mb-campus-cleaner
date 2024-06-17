import 'package:flutter/material.dart';
import 'package:g5_mb_campus_cleaner/screens/admin/news_admin_page.dart';
import 'package:g5_mb_campus_cleaner/screens/user/news_user_page.dart';
import 'package:g5_mb_campus_cleaner/screens/user/cleaner/report_to_resolve_list_cleaner_page.dart';
import 'package:g5_mb_campus_cleaner/screens/admin/report_to_asign_list_admin_page.dart';
import 'package:g5_mb_campus_cleaner/screens/user/unmsm-member/report_history_unmsm_member_page.dart';
import 'package:g5_mb_campus_cleaner/screens/user/unmsm-member/welcome_unmsm_member_page.dart';

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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ReportToAsignListAdminPage()));
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
                    builder: (context) => ReportToResolveListCleanerPage()));
          case 1:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NewsUserPage()));
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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const WelcomeUnmsmMemberPage()));
          case 1:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const ReportHistoryUnmsmMemberPage()));
          case 2:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const NewsUserPage()));
        }
      },
    );
  }
}
