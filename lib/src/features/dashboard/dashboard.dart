import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:g5_mb_campus_cleaner/src/features/detail_report/detail_report.dart';
import 'package:g5_mb_campus_cleaner/src/features/pending_list/pending_list_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Text("MI INFO", style: TextStyle(color: CupertinoColors.black)),
      ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PendingListPage()),
            );
          },
          child: const Text("Ir a reportes")),
      ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DetailReportPage()),
            );
          },
          child: const Text("Ir a Detalle"))
    ]);
  }
}
