class UserModel {
  String email;
  String name;
  String city;
  String dateOfBirth;
  bool gender;
  String avatar;
  double balance;
  String id;

  UserModel({
    required this.email,
    required this.name,
    required this.city,
    required this.dateOfBirth,
    required this.gender,
    required this.avatar,
    required this.balance,
    required this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json['email'] as String,
        name: json['name'] as String,
        city: json['city'] as String,
        dateOfBirth: json['dateOfBirth'] as String,
        gender: json['gender'] as bool,
        avatar: json['avatar'] as String,
        balance: json['balance'] as double,
        id: json['id'] as String,
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "city": city,
        "dateOfBirth": dateOfBirth,
        "gender": gender,
        "avatar": avatar,
        "balance": balance,
        "id": id,
      };
}

class UserUpdateModel {
  String name;
  String dateOfBirth;
  String city;
  bool gender;
  String avatar;

  UserUpdateModel({
    required this.name,
    required this.dateOfBirth,
    required this.city,
    required this.gender,
    required this.avatar,
  });

  factory UserUpdateModel.fromJson(Map<String, dynamic> json) =>
      UserUpdateModel(
        name: json['name'] as String,
        dateOfBirth: json['dateOfBirth'] as String,
        city: json['city'] as String,
        gender: json['gender'] as bool,
        avatar: json['avatar'] as String,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "dateOfBirth": dateOfBirth,
        "city": city,
        "gender": gender,
        "avatar": avatar,
      };
}
