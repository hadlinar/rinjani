import '../../models/login_user.dart';
import '../network/login_user_service.dart';

class LoginUserRepository {
  final LoginUserService loginUserService;

  LoginUserRepository(this.loginUserService);

  Future<LoginResponse> login({
    required String nik,
    required String password,
  }) async {
    final response = await loginUserService.login({
      "nik": nik,
      "password": password
    });
    print(response.message);
    return response;
  }

}