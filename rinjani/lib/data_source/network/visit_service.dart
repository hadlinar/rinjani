import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../models/visit.dart';
import '../../utils/global.dart';

part 'visit_service.g.dart';

@RestApi(baseUrl: Global.baseURL)

abstract class VisitService{
  static create(Dio dio, {required String baseUrl}) => _VisitService(dio, baseUrl: baseUrl);

  @GET('/visit_cat')
  Future<VisitCategoryResponse> getVisitCategory();
}
