import 'package:json_annotation/json_annotation.dart';
part 'visit.g.dart';

@JsonSerializable()
class VisitCategory{
  String visit_id;
  String visit_name;

  VisitCategory({required this.visit_id, required this.visit_name});

  factory VisitCategory.fromJson(Map<String,dynamic> json) => _$VisitCategoryFromJson(json);
}

@JsonSerializable()
class VisitCategoryResponse{
  String message;
  List<VisitCategory> result;

  VisitCategoryResponse(this.message, this.result);

  factory VisitCategoryResponse.fromJson(Map<String,dynamic> json) => _$VisitCategoryResponseFromJson(json);
}

@JsonSerializable()
class Visit{
  String visit_no;
  String visit_id;
  String branch_id;
  String cust_name;
  String cust_id;
  DateTime time_start;
  DateTime time_finish;
  String user_id;
  String description;
  String pic_position;
  String pic_name;
  String status_visit;

  Visit({
    required this.visit_no,
    required this.visit_id,
    required this.branch_id,
    required this.cust_name,
    required this.cust_id,
    required this.time_start,
    required this.time_finish,
    required this.user_id,
    required this.description,
    required this.pic_position ,
    required this.pic_name,
    required this.status_visit,
  });

  factory Visit.fromJson(Map<String,dynamic> json) => _$VisitFromJson(json);
}


@JsonSerializable()
class VisitResponse{
  String message;
  List<Visit> result;

  VisitResponse(this.message, this.result);

  factory VisitResponse.fromJson(Map<String,dynamic> json) => _$VisitResponseFromJson(json);
}

@JsonSerializable()
class Realization{
  String visit_no;
  String real_no;
  String branch_id;
  String branch;
  String cust_id;
  String customer;
  DateTime time_start;
  DateTime time_finish;
  String user_id;
  String employee;
  String description;
  String pic_position;
  String pic_name;
  String status_visit;
  double latitude;
  double longitude;
  String description_real;

  Realization({
    required this.visit_no,
    required this.real_no,
    required this.branch_id,
    required this.branch,
    required this.cust_id,
    required this.customer,
    required this.time_start,
    required this.time_finish,
    required this.user_id,
    required this.employee,
    required this.description,
    required this.pic_position,
    required this.pic_name,
    required this.status_visit,
    required this.latitude,
    required this.longitude,
    required this.description_real
  });

  factory Realization.fromJson(Map<String,dynamic> json) => _$RealizationFromJson(json);
}

@JsonSerializable()
class RealizationResponse{
  String message;
  List<Realization> result;

  RealizationResponse(this.message, this.result);

  factory RealizationResponse.fromJson(Map<String,dynamic> json) => _$RealizationResponseFromJson(json);
}

@JsonSerializable()
class PostVisit{
  String visit_id;
  String branch_id;
  String cust_id;
  String time_start;
  String time_finish;
  String user_id;
  String description;
  String pic_position;
  String pic_name;
  String status_visit;

  PostVisit({
    required this.visit_id,
    required this.branch_id,
    required this.cust_id,
    required this.time_start,
    required this.time_finish,
    required this.user_id,
    required this.description,
    required this.pic_position,
    required this.pic_name,
    required this.status_visit,
  });

  factory PostVisit.fromJson(Map<String,dynamic> json) => _$PostVisitFromJson(json);
}

@JsonSerializable()
class PostVisitResponse{
  String message;

  PostVisitResponse(this.message);

  factory PostVisitResponse.fromJson(Map<String,dynamic> json) => _$PostVisitResponseFromJson(json);
}

@JsonSerializable()
class PostReal{
  String visit_no;
  String branch_id;
  String cust_id;
  String time_start;
  String time_finish;
  String description;
  String pic_position;
  String pic_name;
  String status_visit;
  String latitude;
  String longitude;
  String description_real;

  PostReal({
    required this.visit_no,
    required this.branch_id,
    required this.cust_id,
    required this.time_start,
    required this.time_finish,
    required this.description,
    required this.pic_position,
    required this.pic_name,
    required this.status_visit,
    required this.latitude,
    required this.longitude,
    required this.description_real
  });

  factory PostReal.fromJson(Map<String,dynamic> json) => _$PostRealFromJson(json);
}

@JsonSerializable()
class PostRealResponse{
  String message;

  PostRealResponse(this.message);

  factory PostRealResponse.fromJson(Map<String,dynamic> json) => _$PostRealResponseFromJson(json);
}

@JsonSerializable()
class DeleteVisitResponse{
  String message;

  DeleteVisitResponse(this.message);

  factory DeleteVisitResponse.fromJson(Map<String,dynamic> json) => _$DeleteVisitResponseFromJson(json);
}

@JsonSerializable()
class Activity{
  String in_office;
  String out_office;
  String off_act;
  String all_act;
  String prs_in;
  String prs_out;
  String prs_off;

  Activity({
    required this.in_office,
    required this.out_office,
    required this.off_act,
    required this.all_act,
    required this.prs_in,
    required this.prs_out,
    required this.prs_off,
  });

  factory Activity.fromJson(Map<String,dynamic> json) => _$ActivityFromJson(json);
}

@JsonSerializable()
class ActivityResponse{
  String message;
  Activity activity;

  ActivityResponse(this.message, this.activity);

  factory ActivityResponse.fromJson(Map<String,dynamic> json) => _$ActivityResponseFromJson(json);
}

@JsonSerializable()
class Ranking{
  String user_id;
  String name_user;
  String branch_id;
  String branch_name;
  String in_office;
  String out_office;
  String off_act;
  String all_act;

  Ranking({
    required this.user_id,
    required this.name_user,
    required this.branch_id,
    required this.branch_name,
    required this.in_office,
    required this.out_office,
    required this.off_act,
    required this.all_act
  });

  factory Ranking.fromJson(Map<String,dynamic> json) => _$RankingFromJson(json);
}

@JsonSerializable()
class RankingResponse{
  String message;
  List<Ranking> ranking;

  RankingResponse(this.message, this.ranking);

  factory RankingResponse.fromJson(Map<String,dynamic> json) => _$RankingResponseFromJson(json);
}