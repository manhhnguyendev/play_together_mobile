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
  //List<ImageModel> listImageModel;
  String description;
  //UserBalanceModel userBalanceModel;
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
    //required this.listImageModel,
    required this.description,
    //required this.userBalanceModel,
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
        //listImageModel: json['images'] as List<ImageModel>,
        description: json['description'] as String,
        //userBalanceModel: json['userBalance'] as UserBalanceModel,
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
        //"images": listImageModel,
        "description": description,
        //"userBalance": userBalanceModel,
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
