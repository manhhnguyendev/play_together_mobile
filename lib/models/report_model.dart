class ReportModel {
  final String id;
  final String reportMessage;
  final String createdDate;

  ReportModel({
    required this.id,
    required this.reportMessage,
    required this.createdDate,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
        id: json['id'] as String,
        reportMessage: json['reportMessage'] as String,
        createdDate: json['createdDate'] as String,
      );

  Map<String, dynamic> toJson() =>
      {"id": id, "reportMessage": reportMessage, "createDate": createdDate};
}

class ReportCreateModel {
  final String reportMessage;

  ReportCreateModel({
    required this.reportMessage,
  });

  factory ReportCreateModel.fromJson(Map<String, dynamic> json) =>
      ReportCreateModel(
        reportMessage: json['reportMessage'] as String,
      );

  Map<String, dynamic> toJson() => {
        "reportMessage": reportMessage,
      };
}
