import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../models/branch.dart';
import '../../utils/global.dart';

part 'branch_service.g.dart';

@RestApi(baseUrl: Global.baseURL)

abstract class BranchService{
  static create(Dio dio) => _BranchService(dio);

  @GET('/branch')
  Future<BranchResponse> getBranch();
}