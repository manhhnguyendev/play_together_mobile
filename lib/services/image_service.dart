import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:play_together_mobile/helpers/api_url.dart' as apiUrl;
import 'package:play_together_mobile/helpers/config_json.dart' as configJson;
import 'package:play_together_mobile/models/image_model.dart';
import 'package:play_together_mobile/models/response_model.dart';

class ImageService {
  Future<bool?> addMultiImages(
      List<AddImageModel> listImages, dynamic token) async {
    Response response;
    bool? result;
    try {
      response = await post(
        Uri.parse('${apiUrl.images}/multi-images'),
        headers: configJson.headerAuth(token),
        body: json.encoder.convert(listImages),
      );
      if (response.statusCode == 200) {
        result = true;
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<ResponseModel<AddImageModel>?> addImages(
      AddImageModel addImageModel, dynamic token) async {
    Response response;
    ResponseModel<AddImageModel>? result;
    try {
      response = await post(
        Uri.parse(apiUrl.images),
        headers: configJson.headerAuth(token),
        body: jsonEncode(addImageModel.toJson()),
      );
      if (response.statusCode == 200) {
        result =
            ResponseModel<AddImageModel>.fromJson(json.decode(response.body));
      }
    } on Exception {
      rethrow;
    }
    return result;
  }

  Future<bool?> deleteImage(String imageId, dynamic token) async {
    Response response;
    bool? result;
    try {
      response = await delete(
        Uri.parse('${apiUrl.images}/$imageId'),
        headers: configJson.headerAuth(token),
      );
      if (response.statusCode == 204) {
        result = true;
      }
    } on Exception {
      rethrow;
    }
    return result;
  }
}
