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

class UnActiveBalanceModel {
  String id;
  double money;
  bool isRelease;
  String createdDate;
  String dateActive;

  UnActiveBalanceModel({
    required this.id,
    required this.money,
    required this.isRelease,
    required this.createdDate,
    required this.dateActive,
  });

  factory UnActiveBalanceModel.fromJson(Map<String, dynamic> json) =>
      UnActiveBalanceModel(
        id: json['id'] as String,
        money: json['money'] as double,
        isRelease: json['isRelease'] as bool,
        createdDate: json['createdDate'] as String,
        dateActive: json['dateActive'] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "money": money,
        "isRelease": isRelease,
        "createdDate": createdDate,
        "dateActive": dateActive,
      };
}
