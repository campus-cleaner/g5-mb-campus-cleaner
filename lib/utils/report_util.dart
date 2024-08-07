import 'dart:io';
import 'package:flutter/material.dart';
import 'package:g5_mb_campus_cleaner/models/pending_report.dart';
import 'package:g5_mb_campus_cleaner/screens/report_detail_page.dart';
import 'package:g5_mb_campus_cleaner/screens/user/cleaner/report_to_resolve_detail_cleaner_page.dart';

class ReportUtil {
  static Future<void> navigateToReportDetailPage(
      {required BuildContext context,
      required File image,
      required PendingReport report,
      required int userTypeIndex,
      required int currentIndex}) async {
    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReportDetailPage(
            userName: report.userRegister!,
            userTypeIndex: userTypeIndex,
            currentIndex: currentIndex,
            reference: report.reference!,
            comment: report.comment!,
            dateTime: report.dateReport!,
            latitude: report.latitude!,
            longitude: report.longitude!,
            image: image,
          ),
        ),
      );
    }
  }

  static Future<void> navigateToReportToResolveDetailCleanerPage(
      {required BuildContext context,
      required File image,
      required PendingReport report,
      required int userTypeIndex,
      required int currentIndex}) async {
    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReportToResolveDetailCleanerPage(
            id: report.id,
            userName: report.userRegister!,
            userTypeIndex: userTypeIndex,
            currentIndex: currentIndex,
            reference: report.reference!,
            comment: report.comment!,
            dateTime: report.dateReport!,
            latitude: report.latitude!,
            longitude: report.longitude!,
            image: image,
          ),
        ),
      );
    }
  }
}
