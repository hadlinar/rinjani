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

  Future<VisitRealByIdResponse> getVisitRealizationById(String id) async {
    final response = await visitService.getVisitRealizationById(id);
    return response;
  }

  Future<VisitResponse> getVisit() async {
    final response = await visitService.getVisit();
    return response;
  }

  Future<VisitByIdResponse> getVisitById(String id) async {
    final response = await visitService.getVisitById(id);
    return response;
  }

  Future<PostVisitResponse> postVisit({
    String visit_cat,
    String branch_id,
    String cust_id,
    String time_start,
    String time_finish,
    String description,
    String pic_position,
    String pic_name,
    String status_visit,
    String userId,
  }) async {
    final response = await visitService.addVisit({
      "visit_cat": visit_cat,
      "branch_id": branch_id,
      "cust_id": cust_id,
      "time_start": time_start,
      "time_finish": time_finish,
      "description": description,
      "pic_position": pic_position,
      "pic_name": pic_name,
      "status_visit": status_visit
    }, userId);
    return response;
  }

  Future<PostRealResponse> postRealization({
    String visit_no,
    String branch_id,
    String cust_id,
    String time_start,
    String time_finish,
    String description,
    String pic_position,
    String pic_name,
    String status_visit,
    String latitude,
    String longitude,
    String userId
  }) async {
    final response = await visitService.addRealization({
      "visit_no": visit_no,
      "branch_id": branch_id,
      "cust_id": cust_id,
      "time_start": time_start,
      "time_finish": time_finish,
      "description": description,
      "pic_position": pic_position,
      "pic_name": pic_name,
      "status_visit": status_visit,
      "latitude": latitude,
      "longitude": longitude
    }, userId);
    return response;
  }
}