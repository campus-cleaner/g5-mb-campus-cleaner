import 'package:flutter/material.dart';
import 'package:g5_mb_campus_cleaner/src/features/detail_report/new_report_form_page.dart';
import 'package:g5_mb_campus_cleaner/src/features/news_admin/news_admin_page.dart';
import 'package:g5_mb_campus_cleaner/src/features/news_page/news_page.dart';
import 'package:g5_mb_campus_cleaner/src/features/pending_by_responsible/pending_list_page_by_responsible.dart';
import 'package:g5_mb_campus_cleaner/src/features/pending_list/pending_list_page.dart';
import 'package:g5_mb_campus_cleaner/src/features/reports_by_user/my_reports_page.dart';

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
          case 0:
            switch (index) {
              case 0:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewReportFormPage()));
              case 1:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyReportsPage()));
              case 2:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const NewsPage()));
            }
            break;
          case 1:
            switch (index) {
              case 0:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const PendingListResponsiblePage()));
              case 1:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const NewsPage()));
            }
            break;
          case 2:
            switch (index) {
              case 0:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PendingListPage()));
              case 1:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewsAdminPage()));
            }
            break;
        }
      },
    );
  }

  List<BottomNavigationBarItem> buildItems(int userTypeIndex) {
    if (userTypeIndex == 1 || userTypeIndex == 2) {
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
