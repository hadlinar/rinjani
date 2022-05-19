import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../models/customer.dart';
import '../../models/pdf.dart';
import '../../models/visit.dart';
import '../../utils/global.dart';

part 'visit_service.g.dart';

@RestApi(baseUrl: Global.baseURL)

abstract class VisitService{
  static create(Dio dio) => _VisitService(dio);

  @GET('/visit/category')
  Future<VisitCategoryResponse> getVisitCategory();

  @GET('/visits')
  Future<VisitResponse> getAllVisit();

  @GET('/visit')
  Future<VisitResponse> getVisit(@Header("Authorization") String authorization);

  @GET('/visit/all')
  Future<VisitResponse> getVisitForRealization(@Header("Authorization") String authorization);

  @GET('/realization/{filter}')
  Future<RealizationResponse> getRealization(@Header("Authorization") String authorization, @Path('filter') String filter);

  @GET('/realization_operasional/{branchId}/{filter}')
  Future<RealizationResponse> getRealizationOp(@Path('branchId') String branchId, @Path('filter') String filter);

  @POST('/visit')
  Future<PostVisitResponse> addVisit(@Header("Authorization") String authorization, @Body() Map<String,dynamic> body);

  @POST('/realization')
  Future<PostRealResponse> addRealization(@Header("Authorization") String authorization, @Body() Map<String,dynamic> body);

  @DELETE('/visit/{visitNo}')
  Future<DeleteVisitResponse> deleteVisit(@Header("Authorization") String authorization, @Path('visitNo') String visitNo);

  @GET('/pdf/{startDate}/{endDate}')
  Future<PDFResponse> getPDF(@Header("Authorization") String authorization, @Path('startDate') String startDate, @Path('endDate') String endDate);

  @POST('/add_customer')
  Future<NewCustomerResponse> addCustomer(@Header("Authorization") String authorization, @Body() Map<String,dynamic> body);

}