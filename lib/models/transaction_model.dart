class TransactionModel {
  String id;
  String operation;
  double money;
  String typeOfTransaction;
  String referenceTransactionId;

  TransactionModel({
    required this.id,
    required this.operation,
    required this.money,
    required this.typeOfTransaction,
    required this.referenceTransactionId,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json['id'] as String,
        operation: json['operation'] as String,
        money: json['money'] as double,
        typeOfTransaction: json['typeOfTransaction'] as String,
        referenceTransactionId: json['referenceTransactionId'] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "operation": operation,
        "money": money,
        "typeOfTransaction": typeOfTransaction,
        "referenceTransactionId": referenceTransactionId,
      };
}

// List<TransactionModel> demoListTransaction = [
//   TransactionModel(
//       id: 1,
//       referenceTransactionId: 1,
//       type: 'Deposit',
//       operation: '+',
//       money: 100000,
//       dateTime: DateTime.parse('2022-03-03 20:00:00')),
//   TransactionModel(
//       id: 2,
//       referenceTransactionId: 1,
//       type: 'Withdraw',
//       operation: '-',
//       money: 100000,
//       dateTime: DateTime.parse('2022-03-03 20:00:00')),
//   TransactionModel(
//       id: 3,
//       referenceTransactionId: 1,
//       type: 'Donate',
//       operation: '-',
//       money: 100000,
//       dateTime: DateTime.parse('2022-03-03 20:00:00')),
//   TransactionModel(
//       id: 4,
//       referenceTransactionId: 1,
//       type: 'Order',
//       operation: '+',
//       money: 100000,
//       dateTime: DateTime.parse('2022-03-03 20:00:00')),
//   TransactionModel(
//       id: 5,
//       referenceTransactionId: 1,
//       type: 'Order',
//       operation: '-',
//       money: 100000,
//       dateTime: DateTime.parse('2022-03-03 20:00:00')),
//   TransactionModel(
//       id: 6,
//       referenceTransactionId: 1,
//       type: 'Order - Refund',
//       operation: '+',
//       money: 100000,
//       dateTime: DateTime.parse('2022-03-03 20:00:00'))
// ];
