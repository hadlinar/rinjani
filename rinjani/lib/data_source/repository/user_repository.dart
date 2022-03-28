import 'package:rinjani/models/user.dart';

// import '../../models/Login.dart';
import '../network/user_service.dart';

class UserRepository {
  final UserService userService;

  UserRepository(this.userService);

  Future<UserResponse> getUser(String token) async {
    final response = await userService.getUser(token);
    return response;
  }

  Future<AllUserResponse> getAllUser() async {
    final response = await userService.getAllUser();
    return response;
  }
}