import 'package:play_together_mobile/models/user_model.dart';

class RatingModel {
  final String id;
  final UserModel? user;
  final int rate;
  final String createdDate;
  final String comment;

  RatingModel({
    required this.id,
    required this.user,
    required this.rate,
    required this.createdDate,
    required this.comment,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
        id: json['id'] as String,
        user: (json['user']) != null ? UserModel.fromJson(json['user']) : null,
        rate: json['rate'] as int,
        comment: json['comment'] as String,
        createdDate: json['createdDate'] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "rate": rate,
        "comment": comment,
        "createDate": createdDate
      };
}

class RatingCreateModel {
  final int rate;
  final String comment;

  RatingCreateModel({
    required this.rate,
    required this.comment,
  });

  factory RatingCreateModel.fromJson(Map<String, dynamic> json) =>
      RatingCreateModel(
        rate: json['rate'] as int,
        comment: json['comment'] as String,
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "comment": comment,
      };
}

// List<RatingModel> demoRating = [
//   RatingModel(
//       id: 1,
//       name: 'vuquochung',
//       avatar: "assets/images/defaultprofile.png",
//       rating: 5,
//       comment: 'Vui vẻ thân thiện',
//       date: DateTime.parse('2022-03-03 20:00:00')),
//   RatingModel(
//       id: 2,
//       name: 'vuquochung2',
//       avatar: "assets/images/defaultprofile.png",
//       rating: 4,
//       comment: 'Vui vẻ thân thiện',
//       date: DateTime.parse('2022-03-02 20:00:00')),
//   RatingModel(
//       id: 3,
//       name: 'vuquochung3',
//       avatar: "assets/images/defaultprofile.png",
//       rating: 3,
//       comment: 'Tạm ổn',
//       date: DateTime.parse('2022-03-01 20:00:00')),
//   RatingModel(
//       id: 4,
//       name: 'vuquochung4',
//       avatar: "assets/images/defaultprofile.png",
//       rating: 2,
//       comment: 'Thông tin không đúng',
//       date: DateTime.parse('2022-02-01 20:00:00')),
//   RatingModel(
//       id: 5,
//       name: 'vuquochung5',
//       avatar: "assets/images/defaultprofile.png",
//       rating: 1,
//       comment: 'Dịch vụ tệ',
//       date: DateTime.parse('2022-01-01 20:00:00')),
// ];
