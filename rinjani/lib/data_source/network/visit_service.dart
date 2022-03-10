import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../models/visit.dart';
import '../../utils/global.dart';

part 'visit_service.g.dart';

@RestApi(baseUrl: Global.baseURL)

abstract class VisitService{
  static create(Dio dio, {required String baseUrl}) => _VisitService(dio, baseUrl: baseUrl);

  @GET('/visit/category')
  Future<VisitCategoryResponse> getVisitCategory();

  @GET('/realization')
  Future<VisitRealResponse> getVisitRealization();

  @GET('/realization/{userId}')
  Future<VisitRealByIdResponse> getVisitRealizationById(@Path("userId") String userId);

  @GET('/visits')
  Future<VisitResponse> getVisit();

  @GET('/visit/')
  Future<VisitByIdResponse> getVisitById(@Path('userId') String userId);

  @POST('/realization/userId?userId={userId}')
  Future<PostRealResponse> addRealization(@Body() Map<String,dynamic> body, @Path("id") String id);

  @POST('/visit/add/{id}')
  Future<PostVisitResponse> addVisit(@Body() Map<String,dynamic> body, @Path("id") String id);

}
