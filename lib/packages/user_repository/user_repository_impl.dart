import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktok_clone/api/api_service_impl.dart';
import 'package:tiktok_clone/packages/models/user_model.dart';

class UserRepository {

  UserModel? user;
  int? userId;

  void setUser(SharedPreferences prefs) async {
    await prefs.setInt("userId", user!.id);
    print("Аккаунт сохранён: ${user!.name}");
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