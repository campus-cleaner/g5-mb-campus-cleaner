import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:g5_mb_campus_cleaner/src/features/detail_report/detail_report.dart';
import 'package:g5_mb_campus_cleaner/src/features/pending_list/PendingListPage.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(children: [
      Text("MI INFO", style: TextStyle(color: CupertinoColors.black)),
      ElevatedButton(onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PendingListPage()),
        );
      }, child: Text("Ir a reportes")),
      ElevatedButton(onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DetailReportPage()),
        );
      }, child: Text("Ir a Detalle"))
    ]);
  }
}
