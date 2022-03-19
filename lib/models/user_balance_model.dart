class UserBalanceModel {
  String id;
  double balance;
  double activeBalance;

  UserBalanceModel({
    required this.id,
    required this.balance,
    required this.activeBalance,
  });

  factory UserBalanceModel.fromJson(Map<String, dynamic> json) =>
      UserBalanceModel(
        id: json['id'] as String,
        balance: json['balance'] as double,
        activeBalance: json['activeBalance'] as double,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "balance": balance,
        "activeBalance": activeBalance,
      };
}
