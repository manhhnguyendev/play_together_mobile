import 'package:play_together_mobile/models/image_model.dart';
import 'package:play_together_mobile/models/user_balance_model.dart';

class UserModel {
  String id;
  String avatar;
  String name;
  bool isPlayer;
  String dateOfBirth;
  String city;
  bool gender;
  String email;
  List<ImageModel> images;
  String description;
  UserBalanceModel userBalance;
  String status;
  bool isActive;

  UserModel({
    required this.id,
    required this.avatar,
    required this.name,
    required this.isPlayer,
    required this.dateOfBirth,
    required this.city,
    required this.gender,
    required this.email,
    required this.images,
    required this.description,
    required this.userBalance,
    required this.status,
    required this.isActive,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as String,
        avatar: json['avatar'] as String,
        name: json['name'] as String,
        isPlayer: json['isPlayer'] as bool,
        dateOfBirth: json['dateOfBirth'] as String,
        city: json['city'] as String,
        gender: json['gender'] as bool,
        email: json['email'] as String,
        images: (json['images'] as List<dynamic>?) != null
            ? (json['images'] as List<dynamic>)
                .map((balance) => ImageModel.fromJson(balance))
                .toList()
            : <ImageModel>[],
        description: json['description'] as String,
        userBalance: (json['userBalance']) != null
            ? UserBalanceModel.fromJson(json['userBalance'])
            : UserBalanceModel.fromJson(json),
        status: json['status'] as String,
        isActive: json['isActive'] as bool,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "avatar": avatar,
        "name": name,
        "isPlayer": isPlayer,
        "dateOfBirth": dateOfBirth,
        "city": city,
        "gender": gender,
        "email": email,
        "images": images,
        "description": description,
        "userBalance": userBalance,
        "status": status,
        "isActive": isActive,
      };
}

class UserUpdateModel {
  String name;
  String dateOfBirth;
  String city;
  bool gender;
  String avatar;
  String description;

  UserUpdateModel({
    required this.name,
    required this.dateOfBirth,
    required this.city,
    required this.gender,
    required this.avatar,
    required this.description,
  });

  factory UserUpdateModel.fromJson(Map<String, dynamic> json) =>
      UserUpdateModel(
        name: json['name'] as String,
        dateOfBirth: json['dateOfBirth'] as String,
        city: json['city'] as String,
        gender: json['gender'] as bool,
        avatar: json['avatar'] as String,
        description: json['description'] as String,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "dateOfBirth": dateOfBirth,
        "city": city,
        "gender": gender,
        "avatar": avatar,
        "description": description,
      };
}

class UserServiceModel {
  bool isPlayer;
  double pricePerHour;
  int maxHourHire;

  UserServiceModel({
    required this.isPlayer,
    required this.pricePerHour,
    required this.maxHourHire,
  });

  factory UserServiceModel.fromJson(Map<String, dynamic> json) =>
      UserServiceModel(
        isPlayer: json['isPlayer'] as bool,
        pricePerHour: json['pricePerHour'] as double,
        maxHourHire: json['maxHourHire'] as int,
      );

  Map<String, dynamic> toJson() => {
        "isPlayer": isPlayer,
        "pricePerHour": pricePerHour,
        "maxHourHire": maxHourHire,
      };
}

class PlayerModel {
  String id;
  String avatar;
  String name;
  bool isPlayer;
  String dateOfBirth;
  String city;
  bool gender;
  String email;
  List<ImageModel> images;
  String description;
  double rate;
  int numOfRate;
  String status;
  bool isActive;
  double pricePerHour;
  int maxHourHire;

  PlayerModel(
      {required this.id,
      required this.avatar,
      required this.name,
      required this.isPlayer,
      required this.dateOfBirth,
      required this.city,
      required this.gender,
      required this.email,
      required this.images,
      required this.description,
      required this.rate,
      required this.numOfRate,
      required this.status,
      required this.isActive,
      required this.pricePerHour,
      required this.maxHourHire});

  factory PlayerModel.fromJson(Map<String, dynamic> json) => PlayerModel(
        id: json['id'] as String,
        avatar: json['avatar'] as String,
        name: json['name'] as String,
        isPlayer: json['isPlayer'] as bool,
        dateOfBirth: json['dateOfBirth'] as String,
        city: json['city'] as String,
        gender: json['gender'] as bool,
        email: json['email'] as String,
        images: (json['images'] as List<dynamic>?) != null
            ? (json['images'] as List<dynamic>)
                .map((balance) => ImageModel.fromJson(balance))
                .toList()
            : <ImageModel>[],
        description: json['description'] as String,
        rate: json['rate'] as double,
        numOfRate: json['numOfRate'] as int,
        status: json['status'] as String,
        isActive: json['isActive'] as bool,
        pricePerHour: json['pricePerHour'] as double,
        maxHourHire: json['maxHourHire'] as int,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "avatar": avatar,
        "name": name,
        "isPlayer": isPlayer,
        "dateOfBirth": dateOfBirth,
        "city": city,
        "gender": gender,
        "email": email,
        "images": images,
        "description": description,
        "rate": rate,
        "numOfRate": numOfRate,
        "status": status,
        "isActive": isActive,
        "pricePerHour": pricePerHour,
        "maxHourHire": maxHourHire
      };
}

class MakeDonateModel {
  double money;
  String message;

  MakeDonateModel({
    required this.money,
    required this.message,
  });

  factory MakeDonateModel.fromJson(Map<String, dynamic> json) =>
      MakeDonateModel(
        money: json['money'] as double,
        message: json['message'] as String,
      );

  Map<String, dynamic> toJson() => {
        "money": money,
        "message": message,
      };
}

class IsPlayerModel {
  bool isPlayer;

  IsPlayerModel({
    required this.isPlayer,
  });

  factory IsPlayerModel.fromJson(Map<String, dynamic> json) => IsPlayerModel(
        isPlayer: json['isPlayer'] as bool,
      );

  Map<String, dynamic> toJson() => {
        "isPlayer": isPlayer,
      };
}

class ServiceUserModel {
  double pricePerHour;
  int maxHourHire;

  ServiceUserModel({
    required this.pricePerHour,
    required this.maxHourHire,
  });

  factory ServiceUserModel.fromJson(Map<String, dynamic> json) =>
      ServiceUserModel(
        pricePerHour: json['pricePerHour'] as double,
        maxHourHire: json['maxHourHire'] as int,
      );

  Map<String, dynamic> toJson() => {
        "pricePerHour": pricePerHour,
        "maxHourHire": maxHourHire,
      };
}
