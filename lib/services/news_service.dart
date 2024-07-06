import 'dart:convert';
import 'dart:io';
import 'package:g5_mb_campus_cleaner/global/env.dart';
import 'package:g5_mb_campus_cleaner/models/new.dart';
import 'package:g5_mb_campus_cleaner/models/pending_report.dart';
import 'package:g5_mb_campus_cleaner/models/response.dart';
import 'package:g5_mb_campus_cleaner/models/users_combo.dart';
import 'package:g5_mb_campus_cleaner/utils/image_util.dart';
import 'package:g5_mb_campus_cleaner/utils/logger_util.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';

class NewsService {
  NewsService();
  Future<List<New>> getMyReports() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final response = await http.get(
          Uri.parse('${Environment.apiUrl}/news/list'),
          headers: {'Authorization': 'Bearer ${prefs.getString('token')}'});
      if (response.statusCode == 200) {
        final decoded = await jsonDecode(utf8.decode(response.bodyBytes));
        var list = <New>[];
        for (var item in decoded) {
          var notification = New.fromJson(item);
          list.add(notification);
        }
        return list;
      }
    } catch (e) {
      LoggerUtil.logDebug(e.toString());
    }
    return [];
  }

  Future<Response> saveNew(String title, String urlExternal, File file) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final request = http.MultipartRequest(
      "POST",
      Uri.parse('${Environment.apiUrl}/report/registerPhoto'),
    );
    String? mimeType = lookupMimeType(file.path);
    mimeType ??= 'application/octet-stream';
    request.files.add(
      http.MultipartFile.fromBytes(
        'photo',
        await file.readAsBytes(),
        filename: file.path.split('/').last,
        contentType: MediaType.parse(mimeType),
      ),
    );

    //request.fields.addAll()
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


}
