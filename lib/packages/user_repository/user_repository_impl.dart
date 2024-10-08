import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktok_clone/api/api_service_impl.dart';
import 'package:tiktok_clone/packages/models/user_model.dart';

class UserRepository {

  UserModel? user;
  int? userId;
  SharedPreferences? prefs;

  set setUsr(UserModel? usr) => user = usr;

  UserRepository(this.prefs);

  void setUser() async {
    await prefs!.setInt("userId", user!.id);
    print("Аккаунт сохранён: ${user!.name}");
  }

  Future<void> setLike(int videoId) async {
    try {
      user!.likedVideos.add(videoId);
      await ApiServiceImpl().setLike(videoId, userId, user!.likedVideos.toSet().toList().toString());
      print('Success!');
    } catch (e) {
      print(e.toString());
    }
  }

  void logout() async {
    await prefs!.remove("userId");
    print("Успешный выход!");
  }

  Future<void> unsetLike(int videoId) async {
    try {
      user!.likedVideos.remove(videoId);
      await ApiServiceImpl().setLike(videoId, userId, user!.likedVideos.toSet().toList().toString());
      print('Success!');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<UserModel?> getAuthenticatedUser(int userId) async { 
    try {
      //await Future.delayed(const Duration(seconds: 10));
      var res = await ApiServiceImpl().getAuthenticatedUser(userId);
      return res;
    } catch (e) {
      print(e.toString());
      return null;
    }
    
  }
}