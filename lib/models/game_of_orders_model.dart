import 'package:play_together_mobile/models/game_model.dart';

class GameOfOrdersModel {
  String id;
  String gameId;
  String toUserId;
  GameModel game;

  GameOfOrdersModel({
    required this.id,
    required this.gameId,
    required this.toUserId,
    required this.game,
  });

  factory GameOfOrdersModel.fromJson(Map<String, dynamic> json) =>
      GameOfOrdersModel(
        id: json['id'] as String,
        gameId: json['gameId'] as String,
        toUserId: json['toUserId'] as String,
        game: (json['game']) != null
            ? GameModel.fromJson(json['game'])
            : GameModel.fromJson(json),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gameId": gameId,
        "toUserId": toUserId,
        "game": game,
      };
}
