class SendEmailModel {
  String toEmail;
  String subject;
  String body;
  SendEmailModel({
    required this.toEmail,
    required this.subject,
    required this.body,
  });

  factory SendEmailModel.fromJson(Map<String, dynamic> json) => SendEmailModel(
        toEmail: json['toEmail'] as String,
        subject: json['subject'] as String,
        body: json['body'] as String,
      );

  Map<String, dynamic> toJson() => {
        "toEmail": toEmail,
        "subject": subject,
        "body": body,
      };
}
