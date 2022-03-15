class LoginGoogleModel {
  String providerName;
  String idToken;

  LoginGoogleModel({
    required this.providerName,
    required this.idToken,
  });

  factory LoginGoogleModel.fromJson(Map<String, dynamic> json) =>
      LoginGoogleModel(
        providerName: json['providerName'] as String,
        idToken: json['idToken'] as String,
      );

  Map<String, dynamic> toJson() => {
        "providerName": providerName,
        "idToken": idToken,
      };
}
