import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/constants/api_url.dart' as apiUrl;
import 'package:play_together_mobile/constants/config_json.dart' as configJson;
import 'package:play_together_mobile/models/hobbies_model.dart';

class HobbiesService {
  Future<List<HobbiesModel>?> getHobbiesOfUser(
      String userId, dynamic token) async {
    Response response;
    List<HobbiesModel>? result;
    try {
      response = await get(
        Uri.parse('${apiUrl.users}/$userId/hobbies'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        result =
            body.map((dynamic item) => HobbiesModel.fromJson(item)).toList();
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<bool?> createHobbies(
      List<CreateHobbiesModel> listCreateHobbies, dynamic token) async {
    Response response;
    bool? result;
    try {
      response = await post(
        Uri.parse(apiUrl.hobbies),
        headers: configJson.headerAuth(token),
        body: json.encoder.convert(listCreateHobbies),
      );
      if (response.statusCode == 200) {
        result = true;
      }
    } on Exception {
      rethrow;
    }
    return result;
  }
}
