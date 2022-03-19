class ImageModel {
  String id;
  String imageLink;

  ImageModel({
    required this.id,
    required this.imageLink,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        id: json['id'] as String,
        imageLink: json['imageLink'] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "imageLink": imageLink,
      };
}
