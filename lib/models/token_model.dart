import 'package:play_together_mobile/models/response_list_model.dart';

class TokenModel {
  String message;
  bool success;
  ErrorModel errors;
  String expireDate;

  TokenModel({
    required this.message,
    required this.success,
    required this.errors,
    required this.expireDate,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        message: json['message'] as String,
        success: json['success'] as bool,
        errors: (json['errors']) != null
            ? ErrorModel.fromJson(json['errors'])
            : ErrorModel.fromJson(json),
        expireDate: json['expireDate'] as String,
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "errors": errors,
        "expireDate": expireDate,
      };
}
