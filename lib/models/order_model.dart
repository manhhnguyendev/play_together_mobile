import 'package:play_together_mobile/models/game_of_orders_model.dart';
import 'package:play_together_mobile/models/rating_comment_model.dart';

class OrderModel {
  String id;
  String userId;
  OrderUserModel? user;
  String toUserId;
  OrderUserModel? toUser;
  List<GameOfOrdersModel> gameOfOrders;
  String message;
  String? reason;
  int totalTimes;
  double totalPrices;
  double finalPrices;
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
    required this.gameOfOrders,
    required this.message,
    required this.reason,
    required this.totalTimes,
    required this.totalPrices,
    required this.finalPrices,
    required this.status,
    required this.timeStart,
    required this.timeFinish,
    required this.processExpired,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json['id'] as String,
        userId: json['userId'] as String,
        user: (json['user']) != null
            ? OrderUserModel.fromJson(json['user'])
            : null,
        toUserId: json['toUserId'] as String,
        toUser: (json['toUser']) != null
            ? OrderUserModel.fromJson(json['toUser'])
            : null,
        gameOfOrders: (json['gameOfOrders'] as List<dynamic>?) != null
            ? (json['gameOfOrders'] as List<dynamic>)
                .map((games) => GameOfOrdersModel.fromJson(games))
                .toList()
            : <GameOfOrdersModel>[],
        message: json['message'] as String,
        reason: json['reason'] as String?,
        totalTimes: json['totalTimes'] as int,
        totalPrices: json['totalPrices'] as double,
        finalPrices: json['finalPrices'] as double,
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
        "gameOfOrders": gameOfOrders,
        "message": message,
        "reason": reason,
        "totalTimes": totalTimes,
        "totalPrices": totalPrices,
        "finalPrices": finalPrices,
        "status": status,
        "timeStart": timeStart,
        "timeFinish": timeFinish,
        "processExpired": processExpired,
      };
}

class OrderUserModel {
  String id;
  String name;
  String email;
  String avatar;
  bool isActive;
  bool isPlayer;
  String status;

  OrderUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    required this.isActive,
    required this.isPlayer,
    required this.status,
  });

  factory OrderUserModel.fromJson(Map<String, dynamic> json) => OrderUserModel(
        id: json['id'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
        avatar: json['avatar'] as String,
        isActive: json['isActive'] as bool,
        isPlayer: json['isPlayer'] as bool,
        status: json['status'] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "avatar": avatar,
        "isActive": isActive,
        "isPlayer": isPlayer,
        "status": status,
      };
}

class OrderDetailModel {
  String id;
  String userId;
  OrderUserModel? user;
  String toUserId;
  OrderUserModel? toUser;
  List<GameOfOrdersModel> gameOfOrders;
  String message;
  String? reason;
  int totalTimes;
  double totalPrices;
  double finalPrices;
  List<RatingOrderModel>? ratings;
  String status;
  String timeStart;
  String timeFinish;
  String processExpired;

  OrderDetailModel({
    required this.id,
    required this.userId,
    required this.user,
    required this.toUserId,
    required this.toUser,
    required this.gameOfOrders,
    required this.message,
    required this.reason,
    required this.totalTimes,
    required this.totalPrices,
    required this.finalPrices,
    required this.ratings,
    required this.status,
    required this.timeStart,
    required this.timeFinish,
    required this.processExpired,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailModel(
        id: json['id'] as String,
        userId: json['userId'] as String,
        user: (json['user']) != null
            ? OrderUserModel.fromJson(json['user'])
            : null,
        toUserId: json['toUserId'] as String,
        toUser: (json['toUser']) != null
            ? OrderUserModel.fromJson(json['toUser'])
            : null,
        gameOfOrders: (json['gameOfOrders'] as List<dynamic>?) != null
            ? (json['gameOfOrders'] as List<dynamic>)
                .map((games) => GameOfOrdersModel.fromJson(games))
                .toList()
            : <GameOfOrdersModel>[],
        message: json['message'] as String,
        reason: json['reason'] != null ? json['reason'] as String : null,
        totalTimes: json['totalTimes'] as int,
        totalPrices: json['totalPrices'] as double,
        finalPrices: json['finalPrices'] as double,
        ratings: (json['ratings'] as List<dynamic>?) != null
            ? (json['ratings'] as List<dynamic>)
                .map((ratings) => RatingOrderModel.fromJson(ratings))
                .toList()
            : <RatingOrderModel>[],
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
        "gameOfOrders": gameOfOrders,
        "message": message,
        "reason": reason,
        "totalTimes": totalTimes,
        "totalPrices": totalPrices,
        "finalPrices": finalPrices,
        "ratings": ratings,
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

class RejectOrderModel {
  bool isAccept;
  String reason;

  RejectOrderModel({
    required this.isAccept,
    required this.reason,
  });

  factory RejectOrderModel.fromJson(Map<String, dynamic> json) =>
      RejectOrderModel(
        isAccept: json['isAccept'] as bool,
        reason: json['reason'] as String,
      );

  Map<String, dynamic> toJson() => {
        "isAccept": isAccept,
        "reason": reason,
      };
}
class CancelOrderModel {
  String reason;

  CancelOrderModel({
    required this.reason,
  });

  factory CancelOrderModel.fromJson(Map<String, dynamic> json) =>
      CancelOrderModel(
        reason: json['reason'] as String,
      );

  Map<String, dynamic> toJson() => {
    "reason": reason,
  };
}

class FinishSoonOrderModel {
  String reason;

  FinishSoonOrderModel({
    required this.reason,
  });

  factory FinishSoonOrderModel.fromJson(Map<String, dynamic> json) =>
      FinishSoonOrderModel(
        reason: json['reason'] as String,
      );

  Map<String, dynamic> toJson() => {
        "reason": reason,
      };
}
