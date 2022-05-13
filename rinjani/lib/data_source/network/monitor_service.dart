import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:rinjani/models/monitor.dart';

import '../../utils/global.dart';

part 'monitor_service.g.dart';

@RestApi(baseUrl: Global.baseURL)

abstract class MonitorService{
  static create(Dio dio) => _MonitorService(dio);

  @GET('/monitor')
  Future<MonitorResponse> getMonitor();
}