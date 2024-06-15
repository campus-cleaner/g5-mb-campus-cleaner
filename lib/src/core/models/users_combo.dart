class UserCombo {
  UserCombo({
    this.id,
    this.username,
    this.fullname,
    this.rolCode,
    this.label
  });
  int? id;
  String? username;
  String? fullname;
  String? rolCode;
  String? label;
  factory UserCombo.fromJson(Map<String, dynamic> json) => UserCombo(
    username: json["username"],
    fullname: json["fullname"],
    rolCode: json["rolCode"],
    id: json["id"],
    label: json["label"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullname": fullname,
    "rolCode": rolCode,
  };
}
