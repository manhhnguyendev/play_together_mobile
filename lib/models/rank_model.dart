class RankModel {
  String id;
  int no;
  String name;

  RankModel({
    required this.id,
    required this.no,
    required this.name,
  });

  factory RankModel.fromJson(Map<String, dynamic> json) => RankModel(
        id: json['id'] as String,
        no: json['no'] as int,
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "no": no,
        "name": name,
      };
}
