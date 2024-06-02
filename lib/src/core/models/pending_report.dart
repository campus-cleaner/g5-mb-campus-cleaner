class PendingReport {
  String? location;
  String? status;
  String? dateReport;
  bool? selected;

  PendingReport(
      {this.location, this.status, this.dateReport, this.selected = false});

  factory PendingReport.fromJson(Map<String, dynamic> json) => PendingReport(
        location: json["location"],
        status: json["status"],
        dateReport: json["dateReport"],
        selected: false,
      );

  @override
  String toString() {
    return 'PendingReport{location: $location, status: $status, dateReport: $dateReport, selected: $selected}';
  }
}
