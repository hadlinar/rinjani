import 'package:rinjani/models/user.dart';

// import '../../models/Login.dart';
import '../network/user_service.dart';

class UserRepository {
  final UserService userService;

  UserRepository(this.userService);

  Future<UserTokenResponse> getUserToken({String? token}) async {
    final response = await userService.getUserToken();
    return response;
  }

  Future<UserResponse> getUser(String id) async {
    final response = await userService.getUser(id);
    return response;
  }

  Future<UserResponse> getAllUser() async {
    final response = await userService.getAllUser();
    return response;
  }

  Future<UserTokenResponse> login({
    required String userId,
    required String password,
  }) async {
    final response = await userService.login({
      "nik": userId,
      "password": password
    });
    return response;
  }

}