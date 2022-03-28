import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../models/user.dart';
import '../../utils/global.dart';

part 'user_service.g.dart';

@RestApi(baseUrl: Global.baseURL)

abstract class UserService{
  static create(Dio dio) => _UserService(dio);

  @POST('/user')
  Future<UserResponse> getUser(@Header("Authorization") String authorization);

  @GET('/users')
  Future<AllUserResponse> getAllUser();

}