import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:rinjani/models/login.dart';

import '../../models/logout.dart';
import '../../utils/global.dart';

part 'login_service.g.dart';

@RestApi(baseUrl: Global.baseURL)

abstract class LoginService{
  static create(Dio dio) => _LoginService(dio);

  @POST('/login')
  Future<LoginResponse> login(@Body() Map<String,dynamic> body);

  @POST('/logout')
  Future<LogoutResponse> logout(@Header("Authorization") String authorization);

}