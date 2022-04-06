import 'package:play_together_mobile/models/game_model.dart';
import 'package:play_together_mobile/models/user_model.dart';

class HobbiesModel {
  String id;
  UserModel user;
  GamesModel game;

  HobbiesModel({
    required this.id,
    required this.user,
    required this.game,
  });

  factory HobbiesModel.fromJson(Map<String, dynamic> json) => HobbiesModel(
        id: json['id'] as String,
        user: (json['user']) != null
            ? UserModel.fromJson(json['user'])
            : UserModel.fromJson(json),
        game: (json['game']) != null
            ? GamesModel.fromJson(json['game'])
            : GamesModel.fromJson(json),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "game": game,
      };
}
