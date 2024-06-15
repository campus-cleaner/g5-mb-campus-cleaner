
class PendingReport {
  int? id;
  String? reference;
  String? imageRoute;
  double? latitude;
  double? longitude;
  String? comment;
  String? userRegister;
  int? idUserRegister;
  String? status;
  String? dateReport;
  bool? selected;

  PendingReport(
      {this.id, this.reference, this.imageRoute, this.latitude, this.longitude, this.comment, this.userRegister, this.idUserRegister, this.status, this.dateReport, this.selected = false});

  factory PendingReport.fromJson(Map<String, dynamic> json) => PendingReport(
        id: json['id'],
        reference: json["reference"],
        imageRoute: json["imageRoute"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        comment: json["comment"],
        userRegister: json["userRegister"],
        idUserRegister: json["idUserRegister"],
        status: json["status"],
        dateReport: json["dateReport"],
        selected: false,
      );

  @override
  String toString() {
    return 'PendingReport{location: $reference, status: $status, dateReport: $dateReport, selected: $selected}';
  }
}
