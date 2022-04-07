class ResetPasswordModel {
  String email;
  String newPassword;
  String confirmNewPassword;
  String token;

  ResetPasswordModel({
    required this.email,
    required this.newPassword,
    required this.confirmNewPassword,
    required this.token,
  });

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) =>
      ResetPasswordModel(
        email: json['email'] as String,
        newPassword: json['newPassword'] as String,
        confirmNewPassword: json['confirmNewPassword'] as String,
        token: json['token'] as String,
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "newPassword": newPassword,
        "confirmNewPassword": confirmNewPassword,
        "token": token,
      };
}

class ChangePasswordModel {
  String email;
  String currentPassword;
  String newPassword;
  String confirmNewPassword;

  ChangePasswordModel({
    required this.email,
    required this.currentPassword,
    required this.newPassword,
    required this.confirmNewPassword,
  });

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) =>
      ChangePasswordModel(
        email: json['email'] as String,
        currentPassword: json['currentPassword'] as String,
        newPassword: json['newPassword'] as String,
        confirmNewPassword: json['confirmNewPassword'] as String,
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "currentPassword": currentPassword,
        "newPassword": newPassword,
        "confirmNewPassword": confirmNewPassword,
      };
}

class EmailModel {
  String email;

  EmailModel({
    required this.email,
  });

  factory EmailModel.fromJson(Map<String, dynamic> json) => EmailModel(
        email: json['email'] as String,
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}
