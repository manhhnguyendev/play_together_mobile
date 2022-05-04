class MomoModel {
  String partnerCode;
  String orderId;
  String requestId;
  int amount;
  int responseTime;
  String message;
  int resultCode;
  String payUrl;

  MomoModel({
    required this.partnerCode,
    required this.orderId,
    required this.requestId,
    required this.amount,
    required this.responseTime,
    required this.message,
    required this.resultCode,
    required this.payUrl,
  });

  factory MomoModel.fromJson(Map<String, dynamic> json) => MomoModel(
        partnerCode: json['partnerCode'] as String,
        orderId: json['orderId'] as String,
        requestId: json['requestId'] as String,
        amount: json['amount'] as int,
        responseTime: json['responseTime'] as int,
        message: json['message'] as String,
        resultCode: json['resultCode'] as int,
        payUrl: json['payUrl'] as String,
      );

  Map<String, dynamic> toJson() => {
        "partnerCode": partnerCode,
        "orderId": orderId,
        "requestId": requestId,
        "amount": amount,
        "responseTime": responseTime,
        "message": message,
        "resultCode": resultCode,
        "payUrl": payUrl,
      };
}

class MomoCreateModel {
  String userId;
  double amount;

  MomoCreateModel({
    required this.userId,
    required this.amount,
  });

  factory MomoCreateModel.fromJson(Map<String, dynamic> json) =>
      MomoCreateModel(
        userId: json['userId'] as String,
        amount: json['amount'] as double,
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "amount": amount,
      };
}
