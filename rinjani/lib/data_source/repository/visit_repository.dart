import 'package:rinjani/models/visit.dart';

import '../network/visit_service.dart';

class VisitRepository {
  final VisitService visitService;

  VisitRepository(this.visitService);

  Future<VisitCategoryResponse> getVisitCategory() async {
    final response = await visitService.getVisitCategory();
    return response;
  }

}