
class New {
  int id;
  String label;
  String urlImagen;


  New(
      {required this.id, required this.label, required this.urlImagen});

  factory New.fromJson(Map<String, dynamic> json) => New(
    id: json["id"],
    label: json["label"],
    urlImagen: json["urlImagen"],

  );

  @override
  String toString() {
    return 'CleanerPersonal{id: $id, label: $label}';
  }
}
