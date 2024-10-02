import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktok_clone/api/api_service_impl.dart';
import 'package:tiktok_clone/packages/models/user_model.dart';

class UserRepository {

  late final SharedPreferences _prefs;
  UserModel? user;
  int? userId;

  void initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    await getUserId();
  }

  Future<int?> getUserId() async {
    userId = _prefs.getInt("userId");
    print(userId);
    return userId;
  }

  void setUser() async {
    await _prefs.setInt("userId", user!.id);
    print("Аккаунт сохранён: ${user!.name}");
  }

  Future<UserModel> getAuthenticatedUser() async { 
    try {
      await Future.delayed(const Duration(seconds: 10));
      var res = await ApiServiceImpl().getAuthenticatedUser(userId!);
      return res;
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
    
  }
}