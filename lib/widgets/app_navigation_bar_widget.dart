import 'package:flutter/material.dart';
import 'package:g5_mb_campus_cleaner/global/env.dart';
import 'package:g5_mb_campus_cleaner/screens/user/unmsm-member/report_history_unmsm_member_page.dart';
import 'package:g5_mb_campus_cleaner/screens/user/unmsm-member/report_to_send_form_unmsm_member_page.dart';
import 'package:g5_mb_campus_cleaner/screens/admin/news_admin_page.dart';
import 'package:g5_mb_campus_cleaner/screens/user/news_user_page.dart';
import 'package:g5_mb_campus_cleaner/screens/user/cleaner/report_to_resolve_list_cleaner_page.dart';
import 'package:g5_mb_campus_cleaner/screens/admin/report_to_asign_list_admin_page.dart';

class AppNavigationBarWidget extends StatelessWidget {
  final int currentIndex;
  final int userTypeIndex;

  const AppNavigationBarWidget(
      {super.key, required this.currentIndex, required this.userTypeIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color.fromARGB(255, 31, 172, 90),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      selectedLabelStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontFamily: 'Quicksand',
        fontSize: 15,
      ),
      unselectedLabelStyle: const TextStyle(
        color: Colors.white,
        fontFamily: 'Quicksand',
        fontSize: 15,
      ),
      currentIndex: currentIndex,
      items: buildItems(userTypeIndex),
      onTap: (int index) {
        switch (userTypeIndex) {
          case Environment.unmsmMemberIndex:
            switch (index) {
              case 0:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReportToSendFormUnmsmMemberPage(
                            userTypeIndex: userTypeIndex,
                            currentIndex: index)));
              case 1:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReportHistoryUnmsmMemberPage(
                            userTypeIndex: userTypeIndex,
                            currentIndex: index)));
              case 2:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewsUserPage(
                            userTypeIndex: userTypeIndex,
                            currentIndex: index)));
            }
            break;
          case Environment.cleanerIndex:
            switch (index) {
              case 0:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReportToResolveListCleanerPage(
                            userTypeIndex: userTypeIndex,
                            currentIndex: index)));
              case 1:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewsUserPage(
                            userTypeIndex: userTypeIndex,
                            currentIndex: index)));
            }
            break;
          case Environment.adminIndex:
            switch (index) {
              case 0:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReportToAsignListAdminPage(
                            userTypeIndex: userTypeIndex,
                            currentIndex: index)));
              case 1:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewsAdminPage(
                            currentIndex: index,
                            userTypeIndex: userTypeIndex)));
            }
            break;
        }
      },
    );
  }

  List<BottomNavigationBarItem> buildItems(int userTypeIndex) {
    if (userTypeIndex == Environment.cleanerIndex ||
        userTypeIndex == Environment.adminIndex) {
      return const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.white),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.newspaper, color: Colors.white),
          label: 'Noticias',
        ),
      ];
    } else {
      return const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.white),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.airplane_ticket, color: Colors.white),
          label: 'Mis reportes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications, color: Colors.white),
          label: 'Noticias',
        ),
      ];
    }
  }
}
