import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:g5_mb_campus_cleaner/src/features/dashboard/dashboard.dart';
import 'package:g5_mb_campus_cleaner/src/features/news_admin/NewsAdminPage.dart';
import 'package:g5_mb_campus_cleaner/src/features/news_page/NewsPage.dart';
import 'package:g5_mb_campus_cleaner/src/features/pending_list/PendingListPage.dart';
import 'package:g5_mb_campus_cleaner/src/features/reports_by_user/PendingListPageByUser.dart';

class CampusNavigationBar  {
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
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  PendingListPage()));
          case 1:
            Navigator.push(context, MaterialPageRoute(builder: (context) => NewsAdminPage()));
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
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  PendingListUserPage()));
          case 1:
            Navigator.push(context, MaterialPageRoute(builder: (context) => NewsPage()));
        }

      },
    );
  }
}