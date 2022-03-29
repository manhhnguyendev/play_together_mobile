class CharityModel {
  String id;
  String organizationName;
  String avatar;
  String information;
  String address;
  String email;
  String phone;
  double balance;
  bool isActive;
  String createdDate;

  CharityModel({
    required this.id,
    required this.organizationName,
    required this.avatar,
    required this.information,
    required this.address,
    required this.email,
    required this.phone,
    required this.balance,
    required this.isActive,
    required this.createdDate,
  });

  factory CharityModel.fromJson(Map<String, dynamic> json) => CharityModel(
        id: json['id'] as String,
        organizationName: json['organizationName'] as String,
        avatar: json['avatar'] as String,
        information: json['information'] as String,
        address: json['address'] as String,
        email: json['email'] as String,
        phone: json['phone'] as String,
        balance: json['balance'] as double,
        isActive: json['isActive'] as bool,
        createdDate: json['createdDate'] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "organizationName": organizationName,
        "avatar": avatar,
        "information": information,
        "address": address,
        "email": email,
        "phone": phone,
        "balance": balance,
        "isActive": isActive,
        "createdDate": createdDate,
      };
}
