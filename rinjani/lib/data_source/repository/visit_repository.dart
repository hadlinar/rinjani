import 'package:rinjani/models/visit.dart';

import '../network/visit_service.dart';

class VisitRepository {
  final VisitService visitService;

  VisitRepository(this.visitService);

  Future<VisitCategoryResponse> getVisitCategory() async {
    final response = await visitService.getVisitCategory();
    return response;
  }

  Future<VisitRealResponse> getVisitRealization() async {
    final response = await visitService.getVisitRealization();
    return response;
  }

  Future<VisitResponse> getVisit() async {
    final response = await visitService.getVisit();
    return response;
  }

  Future<PostVisitResponse> postVisit({
    required String visit_cat,
    required String branch_id,
    required String cust_id,
    required DateTime time_start,
    required DateTime time_finish,
    required String user_id,
    required String description,
    required String pic_position,
    required String pic_name,
    required String status_visit,
  }) async {
    final response = await visitService.addVisit({
      "visit_cat": visit_cat,
      "branch_id": branch_id,
      "cust_id": cust_id,
      "time_start": time_start,
      "time_finish": time_finish,
      "user_id": user_id,
      "description": description,
      "pic_position": pic_position,
      "pic_name": pic_name,
      "status_visit": status_visit
    });
    return response;
  }

  Future<PostRealResponse> postRealization({
    required String visit_no,
    required String branch_id,
    required String cust_id,
    required DateTime time_start,
    required DateTime time_finish,
    required String user_id,
    required String description,
    required String pic_position,
    required String pic_name,
    required String status_visit,
    required double latitude,
    required double longitude
  }) async {
    final response = await visitService.addRealization({
      "visit_no": visit_no,
      "branch_id": branch_id,
      "cust_id": cust_id,
      "time_start": time_start,
      "time_finish": time_finish,
      "user_id": user_id,
      "description": description,
      "pic_position": pic_position,
      "pic_name": pic_name,
      "latitude": latitude,
      "longitude": longitude
    });
    return response;
  }
}