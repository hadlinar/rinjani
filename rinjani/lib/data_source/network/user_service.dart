import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../models/user.dart';
import '../../utils/global.dart';

part 'user_service.g.dart';

@RestApi(baseUrl: Global.baseURL)

abstract class UserService{
  static create(Dio dio) => _UserService(dio);

  @GET('/user/{userId}')
  Future<UserResponse> getUser(@Path("userId") String userId);

  @GET('/user')
  Future<UserTokenResponse> getUserToken();

  @GET('/users')
  Future<UserResponse> getAllUser();

  @POST('/login')
  Future<UserTokenResponse> login(@Body() Map<String,dynamic> body);

}