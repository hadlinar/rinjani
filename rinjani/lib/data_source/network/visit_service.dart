import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../models/visit.dart';
import '../../utils/global.dart';

part 'visit_service.g.dart';

@RestApi(baseUrl: Global.baseURL)

abstract class VisitService{
  static create(Dio dio) => _VisitService(dio);

  @GET('/visit/category')
  Future<VisitCategoryResponse> getVisitCategory();

  @GET('/realization')
  Future<VisitRealResponse> getVisitRealization();

  @GET('/realization/{userId}')
  Future<VisitRealByIdResponse> getVisitRealizationById(@Path("userId") String userId);

  @GET('/visits')
  Future<VisitResponse> getVisit();

  @GET('/visit/{userId}')
  Future<VisitByIdResponse> getVisitById(@Path('userId') String userId);

  @GET('/visit/{filter}/{userId}')
  Future<VisitRealByIdResponse> getVisitFilter(@Path('userId') String userId, @Path('filter') String filter);

  @POST('/realization/{userId}')
  Future<PostRealResponse> addRealization(@Body() Map<String,dynamic> body, @Path("userId") String userId);

  @POST('/visit/{userId}')
  Future<PostVisitResponse> addVisit(@Body() Map<String,dynamic> body, @Path("userId") String userId);

}