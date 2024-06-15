import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:g5_mb_campus_cleaner/src/core/global/env.dart';
import 'package:g5_mb_campus_cleaner/src/core/models/pending_report.dart';
import 'package:g5_mb_campus_cleaner/src/core/models/response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ReportService{
  ReportService();
  Future<List<PendingReport>> getMyReports() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await http.get(
          Uri.parse(
              '${Environment.apiUrl}/report/getMyReports'),
          headers: {'Authorization': 'Bearer ${prefs.getString('token')}'});

      if (response.statusCode == 200) {
        final decoded = await jsonDecode(utf8.decode(response.bodyBytes));
        var list = <PendingReport>[];
        for (var item in decoded) {
          var notification = PendingReport.fromJson(item);
          list.add(notification);
        }
        return list;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }

  Future<Response> reportImage(File file) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final request = await http.MultipartRequest("POST",
      Uri.parse(
          '${Environment.apiUrl}/report/getMyReports'),);
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    headers.addAll({"Authorization": 'Bearer ${prefs.getString('token')}'});
    request.files.add(http.MultipartFile('photo', file.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split("/").last));
    request.headers.addAll(headers);
    final response = await request.send();
    var responseData = await response.stream.bytesToString();
    final decodedMap = json.decode(responseData);
    return Response.fromJson(decodedMap);
  }

  Future<List<PendingReport>> getReportsToAttend() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await http.get(
          Uri.parse(
              '${Environment.apiUrl}/report/getReportsByResponsible'),
          headers: {'Authorization': 'Bearer ${prefs.getString('token')}'});

      if (response.statusCode == 200) {
        final decoded = await jsonDecode(utf8.decode(response.bodyBytes));
        var list = <PendingReport>[];
        for (var item in decoded) {
          var notification = PendingReport.fromJson(item);
          list.add(notification);
        }
        return list;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }

  Future<List<PendingReport>> getReportsToAssign() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await http.get(
          Uri.parse(
              '${Environment.apiUrl}/report/getPendingsToAssign'),
          headers: {'Authorization': 'Bearer ${prefs.getString('token')}'});

      if (response.statusCode == 200) {
        final decoded = await jsonDecode(utf8.decode(response.bodyBytes));
        var list = <PendingReport>[];
        for (var item in decoded) {
          var notification = PendingReport.fromJson(item);
          list.add(notification);
        }
        return list;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }
}