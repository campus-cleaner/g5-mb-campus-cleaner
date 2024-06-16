class Response {
  String? code;
  String? message;
  String? status;
  String? data;

  Response(
      {required this.code,
      required this.message,
      required this.status,
      required this.data});

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        code: json["code"],
        message: json["message"],
        status: json["status"],
        data: json["data"],
      );

  @override
  String toString() {
    return 'Response{code: $code, message: $message}';
  }
}
