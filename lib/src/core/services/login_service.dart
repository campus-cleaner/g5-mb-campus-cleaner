
import 'dart:convert';

import 'package:g5_mb_campus_cleaner/src/core/global/env.dart';
import 'package:g5_mb_campus_cleaner/src/core/models/login_response.dart';
import 'package:http/http.dart' as http;

class LoginService {
  Future<LoginResponse?> login(
      {required String username,
        required String password,
        required String? tokenDevice}) async {
    try{
      final response = await http.post(
        Uri.parse('${Environment.apiUrl}/user/signIn'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(<String, dynamic>{
          'username': username,
          'password': password,
          'tokenApp': tokenDevice
        }),
      );
      if(response.statusCode == 200) {
        final decoded = jsonDecode(utf8.decode(response.bodyBytes));
        var responseMsg = LoginResponse.fromJson(decoded);
        return responseMsg;
      } else {
        throw new Exception("User not found");
      }

    } catch (e) {
      print(e);
      return null;
    }

  }
}