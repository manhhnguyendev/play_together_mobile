class TransactionModel {
  final int id;
  final int referenceTransactionId;
  final String type;
  final String operation;
  final double money;
  final DateTime dateTime;

  TransactionModel({
    required this.id,
    required this.referenceTransactionId,
    required this.type,
    required this.operation,
    required this.money,
    required this.dateTime,
  });
}

List<TransactionModel> demoListTransaction = [
  TransactionModel(
      id: 1,
      referenceTransactionId: 1,
      type: 'Deposit',
      operation: '+',
      money: 100000,
      dateTime: DateTime.parse('2022-03-03 20:00:00')),
  TransactionModel(
      id: 2,
      referenceTransactionId: 1,
      type: 'Withdraw',
      operation: '-',
      money: 100000,
      dateTime: DateTime.parse('2022-03-03 20:00:00')),
  TransactionModel(
      id: 3,
      referenceTransactionId: 1,
      type: 'Donate',
      operation: '-',
      money: 100000,
      dateTime: DateTime.parse('2022-03-03 20:00:00')),
  TransactionModel(
      id: 4,
      referenceTransactionId: 1,
      type: 'Order',
      operation: '+',
      money: 100000,
      dateTime: DateTime.parse('2022-03-03 20:00:00')),
  TransactionModel(
      id: 5,
      referenceTransactionId: 1,
      type: 'Order',
      operation: '-',
      money: 100000,
      dateTime: DateTime.parse('2022-03-03 20:00:00'))
];
