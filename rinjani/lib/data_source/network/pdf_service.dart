import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../models/pdf.dart';
import '../../utils/global.dart';

part 'pdf_service.g.dart';

@RestApi(baseUrl: Global.baseURL)

abstract class PDFService{
  static create(Dio dio) => _PDFService(dio);

  @GET('/pdf/{startDate}/{endDate}')
  Future<PDFResponse> getPDF(@Header("Authorization") String authorization, @Path('startDate') String startDate, @Path('endDate') String endDate);
}