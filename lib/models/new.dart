
class New {
  int id;
  String title;
  String urlExternal;
  String urlImagen;


  New(
      {required this.id, required this.title, required this.urlExternal, required this.urlImagen});

  factory New.fromJson(Map<String, dynamic> json) => New(
    id: json["id"],
    title: json["title"],
    urlExternal: json["urlExternal"],
    urlImagen: json["urlImagen"],


  );

  @override
  String toString() {
    return 'CleanerPersonal{id: $id, label: $title}';
  }
}
