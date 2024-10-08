import 'package:tiktok_clone/api/api_service_impl.dart';
import 'package:tiktok_clone/packages/models/user_model.dart';

class AuthRepository {

  const AuthRepository();
  

  Future<void> logout() async {
    throw UnimplementedError();
  }
  

  Future<UserModel?> signIn(String? login, String? phone, String? email, {required String password}) async {
    try {
      var user =  await ApiServiceImpl().login(password, phone, login, email);
      return user;
    } catch (e) {
      throw Exception(e.toString());
    }
    
  }
  

  Future<UserModel?> signUp(String? email, String? login, String? phone, {required String password, required String birth}) async {
    try {
      var user = await ApiServiceImpl().registration(password, birth, phone, login, email);
      return user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  

  Future<bool> isDataBusy(String? login, phone, email) {
    throw UnimplementedError();
  }
  

  Future<void> updateProfileData(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}