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

// List<NotificationModel> demoListNotifications = [
//   NotificationModel(
//       id: 1,
//       receiverId: 1,
//       title: 'Thông báo 1',
//       message: 'Đây là thông báo số 1',
//       status: 'Read',
//       datetime: DateTime.parse('2022-03-03 20:00:00')),
//   NotificationModel(
//       id: 2,
//       receiverId: 1,
//       title: 'Thông báo 2',
//       message: 'Đây là thông báo số 2',
//       status: 'Read',
//       datetime: DateTime.parse('2022-03-02 20:00:00')),
//   NotificationModel(
//       id: 3,
//       receiverId: 1,
//       title: 'Thông báo 3',
//       message: 'Đây là thông báo số 3',
//       status: 'Read',
//       datetime: DateTime.parse('2022-03-01 20:00:00')),
// ];
