class TokenModel {
  String message;
  bool success;
  String expireDate;

  TokenModel({
    required this.message,
    required this.success,
    required this.expireDate,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        message: json['message'] as String,
        success: json['success'] as bool,
        expireDate: json['expireDate'] as String,
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "expireDate": expireDate,
      };
}
