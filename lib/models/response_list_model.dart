import 'package:play_together_mobile/models/charity_model.dart';
import 'package:play_together_mobile/models/chat_model.dart';
import 'package:play_together_mobile/models/game_model.dart';
import 'package:play_together_mobile/models/game_of_user_model.dart';
import 'package:play_together_mobile/models/hobbies_model.dart';
import 'package:play_together_mobile/models/notification_model.dart';
import 'package:play_together_mobile/models/online_hour_model.dart';
import 'package:play_together_mobile/models/order_model.dart';
import 'package:play_together_mobile/models/rank_model.dart';
import 'package:play_together_mobile/models/rating_comment_model.dart';
import 'package:play_together_mobile/models/search_history_model.dart';
import 'package:play_together_mobile/models/transaction_model.dart';
import 'package:play_together_mobile/models/user_model.dart';

class ResponseListModel<T> {
  int currentPage;
  int totalPages;
  int pageSize;
  int totalCount;
  bool hasPrevious;
  bool hasNext;
  late List<T> content;
  ErrorModel error;
  bool isSuccess;
  String responseTime;

  ResponseListModel._fromJson(Map<String, dynamic> parsedJson)
      : currentPage = parsedJson['currentPage'],
        totalPages = parsedJson['totalPages'],
        pageSize = parsedJson['pageSize'],
        totalCount = parsedJson['totalCount'],
        hasPrevious = parsedJson['hasPrevious'],
        hasNext = parsedJson['hasNext'],
        error = (parsedJson['error']) != null
            ? ErrorModel.fromJson(parsedJson['error'])
            : ErrorModel.fromJson(parsedJson),
        isSuccess = parsedJson['isSuccess'],
        responseTime = parsedJson['responseTime'];

  factory ResponseListModel.fromJson(Map<String, dynamic> json) {
    if (T == UserModel) {
      return ListUserModelResponse.fromJson(json) as ResponseListModel<T>;
    } else if (T == HobbiesModel) {
      return ListHobbiesModelResponse.fromJson(json) as ResponseListModel<T>;
    } else if (T == GameOfUserModel) {
      return ListGameOfUserModelResponse.fromJson(json) as ResponseListModel<T>;
    } else if (T == CharityModel) {
      return ListCharityModelResponse.fromJson(json) as ResponseListModel<T>;
    } else if (T == RatingModel) {
      return ListRatingModelResponse.fromJson(json) as ResponseListModel<T>;
    } else if (T == OrderModel) {
      return ListOrderModelResponse.fromJson(json) as ResponseListModel<T>;
    } else if (T == GamesModel) {
      return ListGamesModelResponse.fromJson(json) as ResponseListModel<T>;
    } else if (T == RankModel) {
      return ListRankModelResponse.fromJson(json) as ResponseListModel<T>;
    } else if (T == TransactionModel) {
      return ListTransactionModelResponse.fromJson(json)
          as ResponseListModel<T>;
    } else if (T == SearchHistoryModel) {
      return ListSearchHistoryModelResponse.fromJson(json)
          as ResponseListModel<T>;
    } else if (T == NotificationModel) {
      return ListNotificationModelResponse.fromJson(json)
          as ResponseListModel<T>;
    } else if (T == OnlineHourModel) {
      return ListOnlineHourModelResponse.fromJson(json) as ResponseListModel<T>;
    } else if (T == ChatModel) {
      return ListChatModelResponse.fromJson(json) as ResponseListModel<T>;
    }
    throw UnsupportedError('Not Supported Type');
  }
}

class ListUserModelResponse extends ResponseListModel<UserModel> {
  ListUserModelResponse.fromJson(Map<String, dynamic> json)
      : super._fromJson(json) {
    content = (json['content'] as List<dynamic>)
        .map((dynamic item) => UserModel.fromJson(item))
        .toList();
  }
}

class ListGameOfUserModelResponse extends ResponseListModel<GameOfUserModel> {
  ListGameOfUserModelResponse.fromJson(Map<String, dynamic> json)
      : super._fromJson(json) {
    content = (json['content'] as List<dynamic>)
        .map((dynamic item) => GameOfUserModel.fromJson(item))
        .toList();
  }
}

class ListNotificationModelResponse
    extends ResponseListModel<NotificationModel> {
  ListNotificationModelResponse.fromJson(Map<String, dynamic> json)
      : super._fromJson(json) {
    content = (json['content'] as List<dynamic>)
        .map((dynamic item) => NotificationModel.fromJson(item))
        .toList();
  }
}

class ListTransactionModelResponse extends ResponseListModel<TransactionModel> {
  ListTransactionModelResponse.fromJson(Map<String, dynamic> json)
      : super._fromJson(json) {
    content = (json['content'] as List<dynamic>)
        .map((dynamic item) => TransactionModel.fromJson(item))
        .toList();
  }
}

class ListCharityModelResponse extends ResponseListModel<CharityModel> {
  ListCharityModelResponse.fromJson(Map<String, dynamic> json)
      : super._fromJson(json) {
    content = (json['content'] as List<dynamic>)
        .map((dynamic item) => CharityModel.fromJson(item))
        .toList();
  }
}

class ListSearchHistoryModelResponse
    extends ResponseListModel<SearchHistoryModel> {
  ListSearchHistoryModelResponse.fromJson(Map<String, dynamic> json)
      : super._fromJson(json) {
    content = (json['content'] as List<dynamic>)
        .map((dynamic item) => SearchHistoryModel.fromJson(item))
        .toList();
  }
}

class ListRatingModelResponse extends ResponseListModel<RatingModel> {
  ListRatingModelResponse.fromJson(Map<String, dynamic> json)
      : super._fromJson(json) {
    content = (json['content'] as List<dynamic>)
        .map((dynamic item) => RatingModel.fromJson(item))
        .toList();
  }
}

class ListRankModelResponse extends ResponseListModel<RankModel> {
  ListRankModelResponse.fromJson(Map<String, dynamic> json)
      : super._fromJson(json) {
    content = (json['content'] as List<dynamic>)
        .map((dynamic item) => RankModel.fromJson(item))
        .toList();
  }
}

class ListOrderModelResponse extends ResponseListModel<OrderModel> {
  ListOrderModelResponse.fromJson(Map<String, dynamic> json)
      : super._fromJson(json) {
    content = (json['content'] as List<dynamic>)
        .map((dynamic item) => OrderModel.fromJson(item))
        .toList();
  }
}

class ListGamesModelResponse extends ResponseListModel<GamesModel> {
  ListGamesModelResponse.fromJson(Map<String, dynamic> json)
      : super._fromJson(json) {
    content = (json['content'] as List<dynamic>)
        .map((dynamic item) => GamesModel.fromJson(item))
        .toList();
  }
}

class ListHobbiesModelResponse extends ResponseListModel<HobbiesModel> {
  ListHobbiesModelResponse.fromJson(Map<String, dynamic> json)
      : super._fromJson(json) {
    content = (json['content'] as List<dynamic>)
        .map((dynamic item) => HobbiesModel.fromJson(item))
        .toList();
  }
}

class ListOnlineHourModelResponse extends ResponseListModel<OnlineHourModel> {
  ListOnlineHourModelResponse.fromJson(Map<String, dynamic> json)
      : super._fromJson(json) {
    content = (json['content'] as List<dynamic>)
        .map((dynamic item) => OnlineHourModel.fromJson(item))
        .toList();
  }
}

class ListChatModelResponse extends ResponseListModel<ChatModel> {
  ListChatModelResponse.fromJson(Map<String, dynamic> json)
      : super._fromJson(json) {
    content = (json['content'] as List<dynamic>)
        .map((dynamic item) => ChatModel.fromJson(item))
        .toList();
  }
}

class ErrorModel {
  int code;
  String type;
  String message;

  ErrorModel({
    required this.code,
    required this.type,
    required this.message,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        code: json['code'] as int,
        type: json['type'] as String,
        message: json['message'] as String,
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "type": type,
        "message": message,
      };
}
