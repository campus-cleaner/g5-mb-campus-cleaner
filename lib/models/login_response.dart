class LoginResponse {
  String? code;
  String? message;
  String userName;
  String token;
  String? rol;

  LoginResponse(
      {required this.code,
      required this.message,
      required this.userName,
      required this.token,
      required this.rol});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        code: json["code"],
        message: json["message"],
        userName: json["userName"],
        token: json["token"],
        rol: json["rol"],
      );

  @override
  String toString() {
    return 'LoginResponse{code: $code, message: $message, userName: $userName, token: $token, rol: $rol}';
  }
}
