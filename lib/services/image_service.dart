import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/constants/api_url.dart' as apiUrl;
import 'package:play_together_mobile/constants/config_json.dart' as configJson;
import 'package:play_together_mobile/models/image_model.dart';

class ImageService {
  Future<AddImageModel?> addImages(
      AddImageModel addImageModel, dynamic token) async {
    Response response;
    AddImageModel? result;
    try {
      response = await post(
        Uri.parse(apiUrl.images),
        headers: configJson.headerAuth(token),
        body: jsonEncode(addImageModel.toJson()),
      );
      if (response.statusCode == 200) {
        result = AddImageModel.fromJson(json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }
}
