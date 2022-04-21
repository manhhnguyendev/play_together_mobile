class RecommendModel {
  String userId;
  String playerId;

  RecommendModel({
    required this.userId,
    required this.playerId,
  });

  factory RecommendModel.fromJson(Map<String, dynamic> json) => RecommendModel(
        userId: json['userId'] as String,
        playerId: json['playerId'] as String,
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "playerId": playerId,
      };
}

class ResultRecommendModel {
  String playerId;
  String score;

  ResultRecommendModel({
    required this.playerId,
    required this.score,
  });

  factory ResultRecommendModel.fromJson(Map<String, dynamic> json) =>
      ResultRecommendModel(
        playerId: json['playerId'] as String,
        score: json['score'] as String,
      );

  Map<String, dynamic> toJson() => {
        "playerId": playerId,
        "score": score,
      };
}
