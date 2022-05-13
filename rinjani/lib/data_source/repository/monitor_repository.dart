import 'package:rinjani/models/monitor.dart';

import '../network/monitor_service.dart';

class MonitorRepository {
  final MonitorService monitorService;

  MonitorRepository(this.monitorService);

  Future<MonitorResponse> getMonitor() async {
    final response = await monitorService.getMonitor();
    return response;
  }
}