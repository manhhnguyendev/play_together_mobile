class HobbiesModel {
  String id;
  HobbiesUserModel user;
  HobbiesGameModel game;

  HobbiesModel({
    required this.id,
    required this.user,
    required this.game,
  });

  factory HobbiesModel.fromJson(Map<String, dynamic> json) => HobbiesModel(
        id: json['id'] as String,
        user: (json['user']) != null
            ? HobbiesUserModel.fromJson(json['user'])
            : HobbiesUserModel.fromJson(json),
        game: (json['game']) != null
            ? HobbiesGameModel.fromJson(json['game'])
            : HobbiesGameModel.fromJson(json),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "game": game,
      };
}

class HobbiesUserModel {
  String id;
  String name;
  String avatar;

  HobbiesUserModel({
    required this.id,
    required this.name,
    required this.avatar,
  });

  factory HobbiesUserModel.fromJson(Map<String, dynamic> json) =>
      HobbiesUserModel(
        id: json['id'] as String,
        name: json['name'] as String,
        avatar: json['avatar'] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
      };
}

class HobbiesGameModel {
  String name;
  String displayName;
  String otherName;

  HobbiesGameModel({
    required this.name,
    required this.displayName,
    required this.otherName,
  });

  factory HobbiesGameModel.fromJson(Map<String, dynamic> json) =>
      HobbiesGameModel(
        name: json['name'] as String,
        displayName: json['displayName'] as String,
        otherName: json['otherName'] as String,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "displayName": displayName,
        "otherName": otherName,
      };
}

class CreateHobbiesModel {
  String gameId;

  CreateHobbiesModel({
    required this.gameId,
  });

  factory CreateHobbiesModel.fromJson(Map<String, dynamic> json) =>
      CreateHobbiesModel(
        gameId: json['gameId'] as String,
      );

  Map<String, dynamic> toJson() => {
        "gameId": gameId,
      };
}

class DeleteHobbiesModel {
  String hobbyId;

  DeleteHobbiesModel({
    required this.hobbyId,
  });

  factory DeleteHobbiesModel.fromJson(Map<String, dynamic> json) =>
      DeleteHobbiesModel(
        hobbyId: json['hobbyId'] as String,
      );

  Map<String, dynamic> toJson() => {
        "hobbyId": hobbyId,
      };
}
