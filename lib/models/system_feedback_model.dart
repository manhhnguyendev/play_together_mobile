class SystemFeedbackModel {
  String id;
  String title;
  String typeOfFeedback;
  String createdDate;
  bool isApprove;

  SystemFeedbackModel({
    required this.id,
    required this.title,
    required this.typeOfFeedback,
    required this.createdDate,
    required this.isApprove,
  });

  factory SystemFeedbackModel.fromJson(Map<String, dynamic> json) =>
      SystemFeedbackModel(
          id: json['id'] as String,
          title: json['title'] as String,
          typeOfFeedback: json['typeOfFeedback'] as String,
          createdDate: json['createdDate'] as String,
          isApprove: json['isApprove'] as bool);

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "typeOfFeedback": typeOfFeedback,
        "createdDate": createdDate,
        "isApprove": isApprove,
      };
}

class CreateFeedBacksModel {
  String title;
  String message;
  String typeOfFeedback;

  CreateFeedBacksModel({
    required this.title,
    required this.message,
    required this.typeOfFeedback,
  });

  factory CreateFeedBacksModel.fromJson(Map<String, dynamic> json) =>
      CreateFeedBacksModel(
        title: json['title'] as String,
        message: json['message'] as String,
        typeOfFeedback: json['typeOfFeedback'] as String,
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "message": message,
        "typeOfFeedback": typeOfFeedback,
      };
}
