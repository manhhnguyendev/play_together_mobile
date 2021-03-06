import 'package:play_together_mobile/models/charity_model.dart';
import 'package:play_together_mobile/models/image_model.dart';
import 'package:play_together_mobile/models/momo_model.dart';
import 'package:play_together_mobile/models/notification_model.dart';
import 'package:play_together_mobile/models/order_model.dart';
import 'package:play_together_mobile/models/rank_model.dart';
import 'package:play_together_mobile/models/system_feedback_model.dart';
import 'package:play_together_mobile/models/user_balance_model.dart';
import 'package:play_together_mobile/models/user_model.dart';

class ResponseModel<T> {
  late T content;
  bool isSuccess;
  String responseTime;

  ResponseModel._fromJson(Map<String, dynamic> parsedJson)
      : isSuccess = parsedJson['isSuccess'],
        responseTime = parsedJson['responseTime'];

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    if (T == UserModel) {
      return UserModelResponse.fromJson(json) as ResponseModel<T>;
    } else if (T == PlayerModel) {
      return PlayerModelResponse.fromJson(json) as ResponseModel<T>;
    } else if (T == UserServiceModel) {
      return UserServiceModelResponse.fromJson(json) as ResponseModel<T>;
    } else if (T == RankModel) {
      return RankModelResponse.fromJson(json) as ResponseModel<T>;
    } else if (T == OrderModel) {
      return OrderModelResponse.fromJson(json) as ResponseModel<T>;
    } else if (T == AddImageModel) {
      return AddImageModelResponse.fromJson(json) as ResponseModel<T>;
    } else if (T == CharityModel) {
      return CharityModelResponse.fromJson(json) as ResponseModel<T>;
    } else if (T == NotificationModel) {
      return NotificationModelResponse.fromJson(json) as ResponseModel<T>;
    } else if (T == OrderDetailModel) {
      return OrderDetailModelResponse.fromJson(json) as ResponseModel<T>;
    } else if (T == GetAllUserModel) {
      return GetAllUserModelResponse.fromJson(json) as ResponseModel<T>;
    } else if (T == BehaviorModel) {
      return BehaviorModelResponse.fromJson(json) as ResponseModel<T>;
    } else if (T == UserBalanceModel) {
      return UserBalanceModelResponse.fromJson(json) as ResponseModel<T>;
    } else if (T == SystemFeedbackDetailModel) {
      return SystemFeedbackDetailModelResponse.fromJson(json)
          as ResponseModel<T>;
    } else if (T == StatisticModel) {
      return StatisticModelResponse.fromJson(json) as ResponseModel<T>;
    } else if (T == MomoModel) {
      return MoMoModelResponse.fromJson(json) as ResponseModel<T>;
    }
    throw UnsupportedError('Not Supported Type');
  }
}

class UserModelResponse extends ResponseModel<UserModel> {
  UserModelResponse.fromJson(Map<String, dynamic> json)
      : super._fromJson(json) {
    content = UserModel.fromJson(json["content"]);
  }
}

class GetAllUserModelResponse extends ResponseModel<GetAllUserModel> {
  GetAllUserModelResponse.fromJson(Map<String, dynamic> json)
      : super._fromJson(json) {
    content = GetAllUserModel.fromJson(json["content"]);
  }
}

class UserBalanceModelResponse extends ResponseModel<UserBalanceModel> {
  UserBalanceModelResponse.fromJson(Map<String, dynamic> json)
      : super._fromJson(json) {
    content = UserBalanceModel.fromJson(json["content"]);
  }
}

class MoMoModelResponse extends ResponseModel<MomoModel> {
  MoMoModelResponse.fromJson(Map<String, dynamic> json)
      : super._fromJson(json) {
    content = MomoModel.fromJson(json["content"]);
  }
}

class StatisticModelResponse extends ResponseModel<StatisticModel> {
  StatisticModelResponse.fromJson(Map<String, dynamic> json)
      : super._fromJson(json) {
    content = StatisticModel.fromJson(json["content"]);
  }
}

class OrderDetailModelResponse extends ResponseModel<OrderDetailModel> {
  OrderDetailModelResponse.fromJson(Map<String, dynamic> json)
      : super._fromJson(json) {
    content = OrderDetailModel.fromJson(json["content"]);
  }
}

class PlayerModelResponse extends ResponseModel<PlayerModel> {
  PlayerModelResponse.fromJson(Map<String, dynamic> json)
      : super._fromJson(json) {
    content = PlayerModel.fromJson(json["content"]);
  }
}

class NotificationModelResponse extends ResponseModel<NotificationModel> {
  NotificationModelResponse.fromJson(Map<String, dynamic> json)
      : super._fromJson(json) {
    content = NotificationModel.fromJson(json["content"]);
  }
}

class UserServiceModelResponse extends ResponseModel<UserServiceModel> {
  UserServiceModelResponse.fromJson(Map<String, dynamic> json)
      : super._fromJson(json) {
    content = UserServiceModel.fromJson(json["content"]);
  }
}

class RankModelResponse extends ResponseModel<RankModel> {
  RankModelResponse.fromJson(Map<String, dynamic> json)
      : super._fromJson(json) {
    content = RankModel.fromJson(json["content"]);
  }
}

class OrderModelResponse extends ResponseModel<OrderModel> {
  OrderModelResponse.fromJson(Map<String, dynamic> json)
      : super._fromJson(json) {
    content = OrderModel.fromJson(json["content"]);
  }
}

class AddImageModelResponse extends ResponseModel<AddImageModel> {
  AddImageModelResponse.fromJson(Map<String, dynamic> json)
      : super._fromJson(json) {
    content = AddImageModel.fromJson(json["content"]);
  }
}

class CharityModelResponse extends ResponseModel<CharityModel> {
  CharityModelResponse.fromJson(Map<String, dynamic> json)
      : super._fromJson(json) {
    content = CharityModel.fromJson(json["content"]);
  }
}

class BehaviorModelResponse extends ResponseModel<BehaviorModel> {
  BehaviorModelResponse.fromJson(Map<String, dynamic> json)
      : super._fromJson(json) {
    content = BehaviorModel.fromJson(json["content"]);
  }
}

class SystemFeedbackDetailModelResponse
    extends ResponseModel<SystemFeedbackDetailModel> {
  SystemFeedbackDetailModelResponse.fromJson(Map<String, dynamic> json)
      : super._fromJson(json) {
    content = SystemFeedbackDetailModel.fromJson(json["content"]);
  }
}
