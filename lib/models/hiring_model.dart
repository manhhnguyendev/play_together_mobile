class HistoryHiringModel {
  final int id;
  final String name;
  final int totalPrice;
  final String status;
  final DateTime datetime;

  HistoryHiringModel({
    required this.id,
    required this.name,
    required this.totalPrice,
    required this.status,
    required this.datetime,
  });
}

List<HistoryHiringModel> demoHistoryHiring = [
  HistoryHiringModel(
      id: 1,
      name: 'Hằng Đàm',
      totalPrice: 1000000,
      status: 'Processing',
      datetime: DateTime.parse('2022-03-03 20:00:00')),
  HistoryHiringModel(
      id: 2,
      name: 'Hằng Đàm',
      totalPrice: 1000000,
      status: 'Complete',
      datetime: DateTime.parse('2022-03-02 18:00:00')),
  HistoryHiringModel(
      id: 3,
      name: 'Hằng Đàm',
      totalPrice: 1000000,
      status: 'Cancel',
      datetime: DateTime.parse('2022-03-02 16:00:00')),
  HistoryHiringModel(
      id: 4,
      name: 'Hằng Đàm',
      totalPrice: 1000000,
      status: 'Complete',
      datetime: DateTime.parse('2022-03-01 18:00:00')),
];
