import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:rinjani/models/login_user.dart';

import '../../utils/global.dart';

part 'login_user_service.g.dart';

@RestApi(baseUrl: Global.baseURL)

abstract class LoginUserService{
  static create(Dio dio) => _LoginUserService(dio);

  @POST('/login')
  Future<LoginResponse> login(@Body() Map<String,dynamic> body);

}