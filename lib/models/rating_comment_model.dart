import 'package:play_together_mobile/models/user_model.dart';

class RatingModel {
  String id;
  UserModel? user;
  int rate;
  String createdDate;
  String comment;

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
