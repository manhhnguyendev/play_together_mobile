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
        id: json['id'],
        no: json['no'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "no": no,
        "name": name,
      };
}
