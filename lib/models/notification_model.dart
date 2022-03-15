class NotificationModel {
  final int id;
  final int receiverId;
  final String title;
  final String status;
  final String message;
  final DateTime datetime;

  NotificationModel({
    required this.id,
    required this.receiverId,
    required this.title,
    required this.status,
    required this.message,
    required this.datetime,
  });
}

List<NotificationModel> demoListNotifications = [
  NotificationModel(
      id: 1,
      receiverId: 1,
      title: 'Thông báo 1',
      message: 'Đây là thông báo số 1',
      status: 'Read',
      datetime: DateTime.parse('2022-03-03 20:00:00')),
  NotificationModel(
      id: 2,
      receiverId: 1,
      title: 'Thông báo 2',
      message: 'Đây là thông báo số 2',
      status: 'Read',
      datetime: DateTime.parse('2022-03-02 20:00:00')),
  NotificationModel(
      id: 3,
      receiverId: 1,
      title: 'Thông báo 3',
      message: 'Đây là thông báo số 3',
      status: 'Read',
      datetime: DateTime.parse('2022-03-01 20:00:00')),
];
