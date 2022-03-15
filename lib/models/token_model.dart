class TokenModel {
  String message;
  String expireDate;

  TokenModel({
    required this.message,
    required this.expireDate,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        message: json['message'] as String,
        expireDate: json['expireDate'] as String,
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "expireDate": expireDate,
      };
}
