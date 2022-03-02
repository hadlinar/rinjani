import 'package:rinjani/models/user.dart';

import '../network/user_service.dart';

class UserRepository {
  final UserService userService;

  UserRepository(this.userService);

  Future<UserResponse> getUser() async {
    final response = await userService.getUser();
    return response;
  }

}