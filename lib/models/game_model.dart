class GameModel {
  String id;
  String name;

  GameModel({
    required this.id,
    required this.name,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) => GameModel(
        id: json['id'] as String,
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class GamesModel {
  String id;
  String name;
  String displayName;
  String otherName;
  GamesModel({
    required this.id,
    required this.name,
    required this.displayName,
    required this.otherName,
  });

  factory GamesModel.fromJson(Map<String, dynamic> json) => GamesModel(
        id: json['id'] as String,
        name: json['name'] as String,
        displayName: json['displayName'] as String,
        otherName: json['otherName'] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "displayName": displayName,
        "otherName": otherName,
      };
}
