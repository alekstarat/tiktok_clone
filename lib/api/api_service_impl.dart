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

  Future<UserModel?> registration(String password, birth, String? phone, login, email) async {
    try {
      var response = await dio.post(
        "$hostUrl/${phone != null ? "phone" : login != null ? "login" : email != null ? "email" : {throw Exception("Некорректный запрос")}}/registration",
        queryParameters: {
          'name' : phone ?? (login ?? (email)),
          'password' : password,
          'birth' : birth
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

  Future<void> subscribe(int fromId, toId) async {
    try {
      await dio.post('$hostUrl/subscribe?idFrom=$fromId&idTo=$toId').then((v) {
        if (v.data == null) {
          print("success subscription!");
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> unsubscribe(int fromId, toId) async {
    try {
      await dio.post('$hostUrl/unsubscribe?idFrom=$fromId&idTo=$toId').then((v) {
        if (v.data == null) {
          print("success unsubscription!");
        }
      });
    } catch (e) {
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

  Future<void> setView(int videoId) async {
    try {
      await dio.post("$hostUrl/update/views?videoId=$videoId");
      print('view updated!');
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<void> setLike(int videoId, userId, String value) async {
    try {
      await dio.post("$hostUrl/set/like?userId=$userId&videoId=$videoId&value=$value");
      print("liked!");
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<void> unsetLike(int videoId, userId, String value) async {
    try {
      await dio.post("$hostUrl/unset/like?userId=$userId&videoId=$videoId&value=$value");
      print("liked!");
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