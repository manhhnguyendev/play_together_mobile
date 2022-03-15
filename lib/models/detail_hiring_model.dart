class DetailHiringModel {
  final int id;
  final int hirerId;
  final String hirerAvatar;
  final String hirerName;
  final int playerId;
  final String playerAvatar;
  final String playerName;
  final int totalHour;
  final int totalPrice;
  final String status;
  final DateTime startTime;
  final double rating;
  final String comment;

  DetailHiringModel(
      {required this.id,
      required this.hirerId,
      required this.hirerAvatar,
      required this.hirerName,
      required this.playerId,
      required this.playerAvatar,
      required this.playerName,
      required this.totalHour,
      required this.totalPrice,
      required this.status,
      required this.rating,
      required this.comment,
      required this.startTime});
}

DetailHiringModel demoDetailHiring = DetailHiringModel(
    id: 1,
    hirerId: 1,
    hirerAvatar: "assets/images/defaultprofile.png",
    hirerName: 'Vu Quoc Hung',
    playerId: 1,
    playerAvatar: 'assets/images/HangDam.png',
    playerName: 'Hằng Đàm',
    totalHour: 2,
    totalPrice: 1000000,
    status: 'Complete',
    rating: 5,
    comment: 'Vui vẻ hòa đồng',
    startTime: DateTime.parse('2022-03-02 18:00:00'));
