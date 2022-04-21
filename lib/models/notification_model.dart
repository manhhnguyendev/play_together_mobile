class NotificationModel {
  String id;
  String title;
  String createdDate;
  String status;

  NotificationModel({
    required this.id,
    required this.title,
    required this.createdDate,
    required this.status,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json['id'] as String,
        title: json['title'] as String,
        createdDate: json['createdDate'] as String,
        status: json['status'] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "createdDate": createdDate,
        "status": status,
      };
}
