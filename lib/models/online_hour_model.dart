class OnlineHourModel {
  String id;
  int fromHour;
  int toHour;
  int dayInWeek;

  OnlineHourModel({
    required this.id,
    required this.fromHour,
    required this.toHour,
    required this.dayInWeek,
  });

  factory OnlineHourModel.fromJson(Map<String, dynamic> json) =>
      OnlineHourModel(
        id: json['id'] as String,
        fromHour: json['fromHour'] as int,
        toHour: json['toHour'] as int,
        dayInWeek: json['dayInWeek'] as int,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fromHour": fromHour,
        "toHour": toHour,
        "dayInWeek": dayInWeek,
      };
}

class CreateOnlineHourModel {
  int fromHour;
  int toHour;
  int dayInWeek;

  CreateOnlineHourModel({
    required this.fromHour,
    required this.toHour,
    required this.dayInWeek,
  });

  factory CreateOnlineHourModel.fromJson(Map<String, dynamic> json) =>
      CreateOnlineHourModel(
        fromHour: json['fromHour'] as int,
        toHour: json['toHour'] as int,
        dayInWeek: json['dayInWeek'] as int,
      );

  Map<String, dynamic> toJson() => {
        "fromHour": fromHour,
        "toHour": toHour,
        "dayInWeek": dayInWeek,
      };
}

class UpdateOnlineHourModel {
  int fromHour;
  int toHour;

  UpdateOnlineHourModel({
    required this.fromHour,
    required this.toHour,
  });

  factory UpdateOnlineHourModel.fromJson(Map<String, dynamic> json) =>
      UpdateOnlineHourModel(
        fromHour: json['fromHour'] as int,
        toHour: json['toHour'] as int,
      );

  Map<String, dynamic> toJson() => {
        "fromHour": fromHour,
        "toHour": toHour,
      };
}
