import 'package:play_together_mobile/models/game_of_orders_model.dart';
import 'package:play_together_mobile/models/user_model.dart';

class OrderModel {
  String id;
  String userId;
  UserModel? user;
  String toUserId;
  UserModel? toUser;
  List<GameOfOrdersModel> gameOfOrderModel;
  String message;
  String reason;
  int totalTimes;
  double totalPrices;
  String status;
  String timeStart;
  String timeFinish;
  String processExpired;

  OrderModel({
    required this.id,
    required this.userId,
    required this.user,
    required this.toUserId,
    required this.toUser,
    required this.gameOfOrderModel,
    required this.message,
    required this.reason,
    required this.totalTimes,
    required this.totalPrices,
    required this.status,
    required this.timeStart,
    required this.timeFinish,
    required this.processExpired,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json['id'] as String,
        userId: json['userId'] as String,
        user: (json['user']) != null ? UserModel.fromJson(json['user']) : null,
        toUserId: json['toUserId'] as String,
        toUser: (json['toUser']) != null
            ? UserModel.fromJson(json['toUser'])
            : null,
        gameOfOrderModel: (json['gameOfOrderModel'] as List<dynamic>?) != null
            ? (json['gameOfOrderModel'] as List<dynamic>)
                .map((games) => GameOfOrdersModel.fromJson(games))
                .toList()
            : <GameOfOrdersModel>[],
        message: json['message'] as String,
        reason: json['reason'] as String,
        totalTimes: json['totalTimes'] as int,
        totalPrices: json['totalPrices'] as double,
        status: json['status'] as String,
        timeStart: json['timeStart'] as String,
        timeFinish: json['timeFinish'] as String,
        processExpired: json['processExpired'] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "user": user,
        "toUserId": toUserId,
        "toUser": toUser,
        "gameOfOrderModel": gameOfOrderModel,
        "message": message,
        "reason": reason,
        "totalTimes": totalTimes,
        "totalPrices": totalPrices,
        "status": status,
        "timeStart": timeStart,
        "timeFinish": timeFinish,
        "processExpired": processExpired,
      };
}

class CreateOrderModel {
  int totalTimes;
  String message;
  List<GameOrderModel>? games;

  CreateOrderModel({
    required this.totalTimes,
    required this.message,
    required this.games,
  });
  factory CreateOrderModel.fromJson(Map<String, dynamic> json) =>
      CreateOrderModel(
        totalTimes: json['totalTimes'] as int,
        message: json['message'] as String,
        games: (json['games'] as List<dynamic>?) != null
            ? (json['games'] as List<dynamic>)
                .map((games) => GameOrderModel.fromJson(games))
                .toList()
            : <GameOrderModel>[],
      );

  Map<String, dynamic> toJson() => {
        "totalTimes": totalTimes,
        "message": message,
        "games": games,
      };
}

class GameOrderModel {
  String gameId;

  GameOrderModel({
    required this.gameId,
  });
  factory GameOrderModel.fromJson(Map<String, dynamic> json) => GameOrderModel(
        gameId: json['gameId'] as String,
      );

  Map<String, dynamic> toJson() => {
        "gameId": gameId,
      };
}

class AcceptOrderModel {
  bool isAccept;

  AcceptOrderModel({
    required this.isAccept,
  });
  factory AcceptOrderModel.fromJson(Map<String, dynamic> json) =>
      AcceptOrderModel(
        isAccept: json['isAccept'] as bool,
      );

  Map<String, dynamic> toJson() => {
        "isAccept": isAccept,
      };
}

class FinishSoonOrderModel {
  String message;

  FinishSoonOrderModel({
    required this.message,
  });
  factory FinishSoonOrderModel.fromJson(Map<String, dynamic> json) =>
      FinishSoonOrderModel(
        message: json['message'] as String,
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
