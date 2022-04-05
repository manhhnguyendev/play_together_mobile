class TransactionModel {
  String id;
  String operation;
  double money;
  String typeOfTransaction;
  String referenceTransactionId;
  String createdDate;

  TransactionModel({
    required this.id,
    required this.operation,
    required this.money,
    required this.typeOfTransaction,
    required this.referenceTransactionId,
    required this.createdDate,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json['id'] as String,
        operation: json['operation'] as String,
        money: json['money'] as double,
        typeOfTransaction: json['typeOfTransaction'] as String,
        referenceTransactionId: json['referenceTransactionId'] as String,
        createdDate: json['createdDate'] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "operation": operation,
        "money": money,
        "typeOfTransaction": typeOfTransaction,
        "referenceTransactionId": referenceTransactionId,
        "createdDate": createdDate,
      };
}
