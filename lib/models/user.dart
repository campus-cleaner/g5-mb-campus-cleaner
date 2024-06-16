class User {
  User({
    this.id,
    this.name,
    this.email,
    this.token,
  });
  int? id;
  String? name;
  String? email;
  String? token;
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
      };
}
