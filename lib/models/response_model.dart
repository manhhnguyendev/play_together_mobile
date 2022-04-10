import 'package:play_together_mobile/models/charity_model.dart';
import 'package:play_together_mobile/models/image_model.dart';
import 'package:play_together_mobile/models/order_model.dart';
import 'package:play_together_mobile/models/rank_model.dart';
import 'package:play_together_mobile/models/register_model.dart';
import 'package:play_together_mobile/models/token_model.dart';
import 'package:play_together_mobile/models/user_model.dart';

class ResponseModel<T> {
  late T content;
  String error;
  bool isSuccess;
  String responseTime;

  ResponseModel._fromJson(Map<String, dynamic> parsedJson)
      : error = parsedJson['error'],
        isSuccess = parsedJson['isSuccess'],
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

class PlayerModelResponse extends ResponseModel<PlayerModel> {
  PlayerModelResponse.fromJson(Map<String, dynamic> json)
      : super._fromJson(json) {
    content = PlayerModel.fromJson(json["content"]);
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
