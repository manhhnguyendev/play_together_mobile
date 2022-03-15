class RatingModel {
  final int id;
  final String name;
  final String avatar;
  final int rating;
  final String comment;
  final DateTime date;

  RatingModel({
    required this.id,
    required this.name,
    required this.avatar,
    required this.rating,
    required this.comment,
    required this.date,
  });
}

List<RatingModel> demoRating = [
  RatingModel(
      id: 1,
      name: 'vuquochung',
      avatar: "assets/images/defaultprofile.png",
      rating: 5,
      comment: 'Vui vẻ thân thiện',
      date: DateTime.parse('2022-03-03 20:00:00')),
  RatingModel(
      id: 2,
      name: 'vuquochung2',
      avatar: "assets/images/defaultprofile.png",
      rating: 4,
      comment: 'Vui vẻ thân thiện',
      date: DateTime.parse('2022-03-02 20:00:00')),
  RatingModel(
      id: 3,
      name: 'vuquochung3',
      avatar: "assets/images/defaultprofile.png",
      rating: 3,
      comment: 'Tạm ổn',
      date: DateTime.parse('2022-03-01 20:00:00')),
  RatingModel(
      id: 4,
      name: 'vuquochung4',
      avatar: "assets/images/defaultprofile.png",
      rating: 2,
      comment: 'Thông tin không đúng',
      date: DateTime.parse('2022-02-01 20:00:00')),
  RatingModel(
      id: 5,
      name: 'vuquochung5',
      avatar: "assets/images/defaultprofile.png",
      rating: 1,
      comment: 'Dịch vụ tệ',
      date: DateTime.parse('2022-01-01 20:00:00')),
];
