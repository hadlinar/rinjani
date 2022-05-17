import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../models/ranking.dart';
import '../../utils/global.dart';

part 'ranking_service.g.dart';

@RestApi(baseUrl: Global.baseURL)

abstract class RankingService{
  static create(Dio dio) => _RankingService(dio);

  @GET('/ranking')
  Future<RankingResponse> getRanking();
}