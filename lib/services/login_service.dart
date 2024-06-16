import 'dart:convert';
import 'package:g5_mb_campus_cleaner/global/env.dart';
import 'package:g5_mb_campus_cleaner/models/login_response.dart';
import 'package:g5_mb_campus_cleaner/utils/logger_util.dart';
import 'package:http/http.dart' as http;

class LoginService {
  Future<LoginResponse?> login(
      {required String username,
      required String password,
      required String? tokenDevice}) async {
    try {
      final response = await http.post(
        Uri.parse('${Environment.apiUrl}/user/signIn'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(<String, dynamic>{
          'username': username,
          'password': password,
          'tokenApp': tokenDevice
        }),
      );
      if (response.statusCode == 200) {
        final decoded = jsonDecode(utf8.decode(response.bodyBytes));
        var responseMsg = LoginResponse.fromJson(decoded);
        return responseMsg;
      } else {
        throw Exception("User $username was not found.");
      }
    } catch (e) {
      LoggerUtil.logError(e.toString());
      return null;
    }
  }

  Future<LoginResponse?> signUp(
      {required String username,
      required String password,
      required String email,
      required String fullname,
      required String phone,
      required String? tokenDevice}) async {
    try {
      final response = await http.post(
        Uri.parse('${Environment.apiUrl}/user/signUp'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(<String, dynamic>{
          'username': username,
          'password': password,
          'tokenApp': tokenDevice,
          'email': email,
          'fullname': fullname,
          'phone': phone
        }),
      );
      if (response.statusCode == 200) {
        final decoded = jsonDecode(utf8.decode(response.bodyBytes));
        var responseMsg = LoginResponse.fromJson(decoded);
        return responseMsg;
      } else {
        throw Exception("User $username can't be registered.");
      }
    } catch (e) {
      LoggerUtil.logError(e.toString());
      return null;
    }
  }
}
