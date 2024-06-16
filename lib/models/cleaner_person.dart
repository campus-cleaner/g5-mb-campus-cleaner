
class CleanerPersonal {
  int id;
  String label;


  CleanerPersonal(
      {required this.id, required this.label});

  factory CleanerPersonal.fromJson(Map<String, dynamic> json) => CleanerPersonal(
    id: json["id"],
    label: json["label"],
  );

  @override
  String toString() {
    return 'CleanerPersonal{id: $id, label: $label}';
  }
}
