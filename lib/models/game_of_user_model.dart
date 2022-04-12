import 'package:play_together_mobile/models/game_model.dart';
import 'package:play_together_mobile/models/rank_model.dart';

class GameOfUserModel {
  String id;
  String gameId;
  GamesModel game;
  String rankId;
  RankModel rank;

  GameOfUserModel({
    required this.id,
    required this.gameId,
    required this.game,
    required this.rankId,
    required this.rank,
  });

  factory GameOfUserModel.fromJson(Map<String, dynamic> json) =>
      GameOfUserModel(
        id: json['id'] as String,
        gameId: json['gameId'] as String,
        game: (json['game']) != null
            ? GamesModel.fromJson(json['game'])
            : GamesModel.fromJson(json),
        rankId: json['rankId'] as String,
        rank: (json['rank']) != null
            ? RankModel.fromJson(json['rank'])
            : RankModel.fromJson(json),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gameId": gameId,
        "game": game,
        "rankId": rankId,
        "rank": rank,
      };
}

class UpdateGameOfUserModel {
  String rankId;

  UpdateGameOfUserModel({
    required this.rankId,
  });

  factory UpdateGameOfUserModel.fromJson(Map<String, dynamic> json) =>
      UpdateGameOfUserModel(
        rankId: json['rankId'] as String,
      );

  Map<String, dynamic> toJson() => {
        "rankId": rankId,
      };
}

class CreateGameOfUserModel {
  String gameId;
  String rankId;

  CreateGameOfUserModel({
    required this.gameId,
    required this.rankId,
  });

  factory CreateGameOfUserModel.fromJson(Map<String, dynamic> json) =>
      CreateGameOfUserModel(
        gameId: json['gameId'] as String,
        rankId: json['rankId'] as String,
      );

  Map<String, dynamic> toJson() => {
        "gameId": gameId,
        "rankId": rankId,
      };
}
