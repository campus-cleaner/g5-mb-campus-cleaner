import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:g5_mb_campus_cleaner/global/env.dart';
import 'package:g5_mb_campus_cleaner/models/pending_report.dart';
import 'package:g5_mb_campus_cleaner/models/response.dart';
import 'package:g5_mb_campus_cleaner/models/users_combo.dart';
import 'package:g5_mb_campus_cleaner/utils/logger_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ReportService {
  ReportService();
  Future<List<PendingReport>> getMyReports() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await http.get(
          Uri.parse('${Environment.apiUrl}/report/getMyReports'),
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
      LoggerUtil.logDebug(e.toString());
    }
    return [];
  }

  Future<Response> reportImage(File file) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final request = http.MultipartRequest(
      "POST",
      Uri.parse('${Environment.apiUrl}/report/registerPhoto'),
    );
    request.files.add(await http.MultipartFile.fromPath('photo', file.path, filename: file.));
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    headers.addAll({"Authorization": 'Bearer ${prefs.getString('token')}'});
    request.headers.addAll(headers);
    final response = await request.send();
    var responseData = await response.stream.bytesToString();
    final decodedMap = json.decode(responseData);
    return Response.fromJson(decodedMap);
  }

  Future<Response> registerReport(
      String imageRoute,
      String reference,
      String comment,
      double latitude,
      double longitude,
      String dateReport) async {
    String params = jsonEncode(<String, dynamic>{
      'id': null,
      'imageRoute': imageRoute,
      'latitude': latitude,
      'longitude': longitude,
      'comment': comment,
      'userRegister': '',
      'idUserRegister': null,
      'status': '',
      'idUserAssigned': null,
      'reference': reference,
      'dateReport': dateReport
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('${Environment.apiUrl}/report/registerReport'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.getString('token')}'
      },
      body: params,
    );
    final decoded = jsonDecode(utf8.decode(response.bodyBytes));
    var responseMsg = Response.fromJson(decoded);
    return responseMsg;
  }

  Future<List<UserCombo>> getCombo() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await http.get(
          Uri.parse('${Environment.apiUrl}/report/getCleaners'),
          headers: {'Authorization': 'Bearer ${prefs.getString('token')}'});

      if (response.statusCode == 200) {
        final decoded = await jsonDecode(utf8.decode(response.bodyBytes));
        var list = <UserCombo>[];
        for (var item in decoded) {
          var notification = UserCombo.fromJson(item);
          list.add(notification);
        }
        return list;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return [];
  }

  Future<List<PendingReport>> getReportsToAttend() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await http.get(
          Uri.parse('${Environment.apiUrl}/report/getReportsByResponsible'),
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
          Uri.parse('${Environment.apiUrl}/report/getPendingsToAssign'),
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

  Future<Response> assignResponsible(String params) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(
      Uri.parse('${Environment.apiUrl}/report/assignResponsible'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${prefs.getString('token')}'
      },
      body: params,
    );
    final decoded = jsonDecode(utf8.decode(response.bodyBytes));
    var responseMsg = Response.fromJson(decoded);
    return responseMsg;
  }
}
