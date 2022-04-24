import 'package:play_together_mobile/models/order_model.dart';

class ChatModel {
  String id;
  OrderUserModel? user;
  String message;
  String createdDate;
  bool isActive;

  ChatModel({
    required this.id,
    required this.user,
    required this.message,
    required this.createdDate,
    required this.isActive,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        id: json['id'] as String,
        user: (json['user']) != null ? OrderUserModel.fromJson(json['user']) : null,
        message: json['message'] as String,
        createdDate: json['createdDate'] as String,
        isActive: json['isActive'] as bool,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "message": message,
        "createdDate": createdDate,
        "isActive": isActive,
      };
}

class SendMessageModel {
  String message;

  SendMessageModel({
    required this.message,
  });

  factory SendMessageModel.fromJson(Map<String, dynamic> json) =>
      SendMessageModel(
        message: json['message'] as String,
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
