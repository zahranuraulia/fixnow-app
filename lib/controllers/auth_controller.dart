import 'package:fixnow/models/user_model.dart';
import 'package:fixnow/services/api_service.dart';

class AuthController {
  final ApiService _apiService = ApiService();
  UserModel? currentUser;

  Future<bool> login(String email, String password) async {
    final user = await _apiService.login(email, password);
    if (user != null) {
      currentUser = user;
      return true;
    }
    return false;
  }
}