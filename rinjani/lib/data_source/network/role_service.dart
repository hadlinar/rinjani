import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:rinjani/models/role.dart';

import '../../utils/global.dart';

part 'role_service.g.dart';

@RestApi(baseUrl: Global.baseURL)

abstract class RoleService{
  static create(Dio dio) => _RoleService(dio);

  @GET('/role')
  Future<RoleResponse> getRole();
}