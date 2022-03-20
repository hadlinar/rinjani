import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../models/employee.dart';
import '../../utils/global.dart';

part 'employee_service.g.dart';

@RestApi(baseUrl: Global.baseURL)

abstract class EmployeeService{
  static create(Dio dio) => _EmployeeService(dio);

  @GET('/employee')
  Future<EmployeeResponse> getEmployee();
}