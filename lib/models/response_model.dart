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
