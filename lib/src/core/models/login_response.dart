class LoginResponse {
  String? code;
  String? message;
  String token;
  String? rol;


  LoginResponse(
      {required this.code, required this.message, required this.token, required this.rol});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    code: json["code"],
    message: json["message"],
    token: json["token"],
    rol: json["rol"],
  );

  @override
  String toString() {
    return 'LoginResponse{code: $code, message: $message, token: $token, rol: $rol}';
  }
}
