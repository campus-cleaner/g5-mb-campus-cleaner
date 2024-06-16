import 'dart:io';
import 'package:flutter/material.dart';
import 'package:g5_mb_campus_cleaner/src/core/models/pending_report.dart';
import 'package:g5_mb_campus_cleaner/src/features/detail_report/detail_report.dart';
import 'package:g5_mb_campus_cleaner/src/utils/image_util.dart';

class ReportUtil {
  static Future<void> navigateToDetailReportPage(
      BuildContext context, PendingReport report) async {
    File imageFile = await ImageUtil.getFileFromAsset(
        "assets/images/garbage.png", "garbage.png");

    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailReportPage(
            reference: report.reference!,
            comment: report.comment!,
            dateTime: report.dateReport!,
            latitude: report.latitude!,
            longitude: report.longitude!,
            image: imageFile,
          ),
        ),
      );
    }
  }
}
