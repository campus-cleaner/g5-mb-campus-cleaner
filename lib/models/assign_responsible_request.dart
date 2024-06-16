class AssignResponsibleReq {
  int idResponsible;
  List<int> reportsToAssign;


  AssignResponsibleReq(
      {required this.idResponsible, required this.reportsToAssign});

  factory AssignResponsibleReq.fromJson(Map<String, dynamic> json) => AssignResponsibleReq(
    reportsToAssign: json["reportsToAssign"],
    idResponsible: json["idResponsible"],
  );

  @override
  String toString() {
    return 'CleanerPersonal{id: $idResponsible, label: $reportsToAssign}';
  }
}
