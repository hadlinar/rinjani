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

  @GET('/realization')
  Future<VisitRealResponse> getVisitRealization();

  @GET('/visit')
  Future<VisitResponse> getVisit();

  @POST('/add_realization')
  Future<PostRealResponse> addRealization(@Body() Map<String,dynamic> body);

  @POST('/add_visit')
  Future<PostVisitResponse> addVisit(@Body() Map<String,dynamic> body);
}
