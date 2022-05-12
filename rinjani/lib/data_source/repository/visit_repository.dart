import 'package:rinjani/models/visit.dart';

import '../../models/customer.dart';
import '../../models/pdf.dart';
import '../network/visit_service.dart';

class VisitRepository {
  final VisitService visitService;

  VisitRepository(this.visitService);

  Future<VisitCategoryResponse> getVisitCategory() async {
    final response = await visitService.getVisitCategory();
    return response;
  }

  Future<VisitResponse> getAllVisit() async {
    final response = await visitService.getAllVisit();
    return response;
  }

  Future<VisitResponse> getVisit(String token) async {
    final response = await visitService.getVisit(token);
    return response;
  }

  Future<VisitResponse> getVisitForRealization(String token) async {
    final response = await visitService.getVisitForRealization(token);
    return response;
  }

  Future<RealizationResponse> getRealization(String token, String filter) async {
    final response = await visitService.getRealization(token, filter);
    return response;
  }

  Future<RealizationResponse> getRealizationOp(String branchId, String filter) async {
    final response = await visitService.getRealizationOp(branchId, filter);
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
    required String token,
  }) async {
    final response = await visitService.addVisit(token, {
      "visit_id": visit_id,
      "branch_id": branch_id,
      "cust_id": cust_id,
      "time_start": time_start,
      "time_finish": time_finish,
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
    required String time_start,
    required String time_finish,
    required String description,
    required String pic_position,
    required String pic_name,
    required String status_visit,
    required String latitude,
    required String longitude,
    required String description_real,
    required String token,
  }) async {
    final response = await visitService.addRealization(token, {
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
      "longitude": longitude,
      "description_real": description_real
    });
    return response;
  }

  Future<DeleteVisitResponse> deleteVisit(String token, String visitNo) async {
    final response = await visitService.deleteVisit(token, visitNo);
    return response;
  }

  Future<PDFResponse> getPDF(String token, String startDate, String endDate) async {
    final response = await visitService.getPDF(token, startDate, endDate);
    return response;
  }

  Future<NewCustomerResponse> addCustomer({
    required String branch_id,
    required String cust_name,
    required String visit_id,
    required String cust_id,
    required String time_start,
    required String time_finish,
    required String description,
    required String pic_position,
    required String pic_name,
    required String status_visit,
    required String token,
  }) async {
    final response = await visitService.addCustomer(token, {
      "branch_id": branch_id,
      "cust_name": cust_name,
      "visit_id": visit_id,
      "cust_id": cust_id,
      "time_start": time_start,
      "time_finish": time_finish,
      "description": description,
      "pic_position": pic_position,
      "pic_name": pic_name,
      "status_visit": status_visit,
    });
    return response;
  }

  Future<ActivityResponse> getActivity(String branchId) async {
    final response = await visitService.getActvity(branchId);
    return response;
  }


  Future<RankingResponse> getRank(String type) async {
    final response = await visitService.getRank(type);
    return response;
  }
}