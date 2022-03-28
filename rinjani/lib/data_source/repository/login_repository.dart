import '../../models/login.dart';
import '../../models/logout.dart';
import '../network/login_service.dart';

class LoginRepository {
  final LoginService loginService;

  LoginRepository(this.loginService);

  Future<LoginResponse> login({
    required String nik,
    required String password,
  }) async {
    final response = await loginService.login({
      "nik": nik,
      "password": password
    });
    return response;
  }

  Future<LogoutResponse> logout(String token) async {
    final response = await loginService.logout(token);
    return response;
  }

}