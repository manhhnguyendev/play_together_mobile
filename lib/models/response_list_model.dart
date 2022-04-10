import 'package:play_together_mobile/models/hobbies_model.dart';

class ResponseListModel<T> {
  int currentPage;
  int totalPages;
  int pageSize;
  int totalCount;
  bool hasPrevious;
  bool hasNext;
  late List<T> content;
  String error;
  bool isSuccess;
  String responseTime;

  ResponseListModel._fromJson(Map<String, dynamic> parsedJson)
      : currentPage = parsedJson['currentPage'],
        totalPages = parsedJson['totalPages'],
        pageSize = parsedJson['pageSize'],
        totalCount = parsedJson['totalCount'],
        hasPrevious = parsedJson['hasPrevious'],
        hasNext = parsedJson['hasNext'],
        error = parsedJson['error'],
        isSuccess = parsedJson['isSuccess'],
        responseTime = parsedJson['responseTime'];

  factory ResponseListModel.fromJson(Map<String, dynamic> json) {
    if (T == HobbiesModel) {
      return HobbiesModelResponse.fromJson(json) as ResponseListModel<T>;
    }
    throw UnsupportedError('Not Supported Type');
  }
}

class HobbiesModelResponse extends ResponseListModel<HobbiesModel> {
  HobbiesModelResponse.fromJson(Map<String, dynamic> json)
      : super._fromJson(json) {
    content = (json['content'] as List<dynamic>)
        .map((dynamic item) => HobbiesModel.fromJson(item))
        .toList();
  }
}
