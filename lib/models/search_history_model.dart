class SearchHistoryModel {
  String id;
  String searchString;

  SearchHistoryModel({
    required this.id,
    required this.searchString,
  });

  factory SearchHistoryModel.fromJson(Map<String, dynamic> json) =>
      SearchHistoryModel(
        id: json['id'] as String,
        searchString: json['searchString'] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "searchString": searchString,
      };
}
