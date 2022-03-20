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
    required String visit_id,
    required String branch_id,
    required String cust_id,
    required String time_start,
    required String time_finish,
    required String description,
    required String pic_position,
    required String pic_name,
    required String status_visit,
    required String userId,
  }) async {
    final response = await visitService.addVisit({
      "visit_id": visit_id,
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
    required String visit_no,
    required String branch_id,
    required String cust_id,
    required String time_start,
    required String time_finish,
    required String description,
    required String pic_position,
    required String pic_name,
    required String status_visit,
    required String latitude,
    required String longitude,
    required String userId
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