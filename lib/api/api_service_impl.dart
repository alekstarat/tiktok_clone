import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tiktok_clone/packages/models/user_model.dart';
import 'package:tiktok_clone/packages/models/video_model.dart';

class ApiServiceImpl {

  final String hostUrl = "http://10.0.2.2:8000";
  final Dio dio = Dio();

  Future<UserModel?> login(String password, String? phone, login, email) async {
    try {
      var response = await dio.post(
        "$hostUrl/${phone != null ? "phone" : login != null ? "login" : email != null ? "email" : {throw Exception("Некорректный запрос")}}/login",
        queryParameters: {
          'name' : phone ?? (login ?? (email)),
          'password' : password
        }
      );
      print(response.data);
      return UserModel.fromJson(response.data);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<UserModel> getAuthenticatedUser(int id) async {
    try {
      var response = await dio.get("$hostUrl/user/$id");
      print(response.data);
      return UserModel.fromJson(response.data);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<VideoModel> getVideo(int id) async {
    try {
      var response = await dio.get("$hostUrl/video/$id");
      print(response.data);
      return VideoModel.fromJson(response.data);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<Map<String, Object?>?> getProfileNameImage(int id) async {
    try {
      var response = await dio.get("$hostUrl/profile_name_image/$id");
      return response.data as Map<String, Object?>?;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

}