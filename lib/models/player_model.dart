class PlayerModel {
  String id;
  String avatar;
  String firstname;
  String lastname;
  double pricePerHour;
  double rating;
  String status;

  PlayerModel({
    required this.id,
    required this.avatar,
    required this.firstname,
    required this.lastname,
    required this.pricePerHour,
    required this.rating,
    required this.status,
  });

  factory PlayerModel.fromJson(Map<String, dynamic> json) => PlayerModel(
        id: json['id'] as String,
        avatar: json['avatar'] as String,
        firstname: json['firstname'] as String,
        lastname: json['lastname'] as String,
        pricePerHour: json['pricePerHour'] as double,
        rating: json['rating'] as double,
        status: json['status'] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "avatar": avatar,
        "firstname": firstname,
        "lastname": lastname,
        "pricePerHour": pricePerHour,
        "rating": rating,
        "status": status,
      };
}
