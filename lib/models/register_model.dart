class RegisterModel {
  String email;
  String password;
  String confirmPassword;
  String name;
  String city;
  String dateOfBirth;
  bool gender;
  bool confirmEmail;

  RegisterModel({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.name,
    required this.city,
    required this.dateOfBirth,
    required this.gender,
    required this.confirmEmail,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        email: json['email'] as String,
        password: json['password'] as String,
        confirmPassword: json['confirmPassword'] as String,
        name: json['name'] as String,
        city: json['city'] as String,
        dateOfBirth: json['dateOfBirth'] as String,
        gender: json['gender'] as bool,
        confirmEmail: json['confirmEmail'] as bool,
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
        "name": name,
        "city": city,
        "dateOfBirth": dateOfBirth,
        "gender": gender,
        "confirmEmail": confirmEmail,
      };
}

class TempRegisterModel {
  String email;
  String password;
  String confirmPassword;
  bool confirmEmail;

  TempRegisterModel({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.confirmEmail,
  });

  factory TempRegisterModel.fromJson(Map<String, dynamic> json) =>
      TempRegisterModel(
        email: json['email'] as String,
        password: json['password'] as String,
        confirmPassword: json['confirmPassword'] as String,
        confirmEmail: json['confirmEmail'] as bool,
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
        "confirmEmail": confirmEmail,
      };
}
