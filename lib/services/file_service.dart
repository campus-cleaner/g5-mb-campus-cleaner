import 'dart:convert';
import 'package:g5_mb_campus_cleaner/global/env.dart';
import 'package:g5_mb_campus_cleaner/models/login_response.dart';
import 'package:g5_mb_campus_cleaner/utils/logger_util.dart';
import 'package:http/http.dart' as http;

class FileService {
  //This string is te reference for
  String getUrlImageFromServer(String filename){
    return '${Environment.apiUrl}/s3/downloadS3File?fileName=${filename}';
  }
}
