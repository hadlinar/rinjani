// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitCategory _$VisitCategoryFromJson(Map<String, dynamic> json) =>
    VisitCategory(
      visit_id: json['visit_id'] as String,
      visit_name: json['visit_name'] as String,
    );

Map<String, dynamic> _$VisitCategoryToJson(VisitCategory instance) =>
    <String, dynamic>{
      'visit_id': instance.visit_id,
      'visit_name': instance.visit_name,
    };

VisitCategoryResponse _$VisitCategoryResponseFromJson(
        Map<String, dynamic> json) =>
    VisitCategoryResponse(
      json['message'] as String,
      (json['result'] as List<dynamic>)
          .map((e) => VisitCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VisitCategoryResponseToJson(
        VisitCategoryResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'result': instance.result,
    };

Visit _$VisitFromJson(Map<String, dynamic> json) => Visit(
      visit_no: json['visit_no'] as String,
      visit_id: json['visit_id'] as String,
      branch_id: json['branch_id'] as String,
      cust_name: json['cust_name'] as String,
      cust_id: json['cust_id'] as String,
      time_start: DateTime.parse(json['time_start'] as String),
      time_finish: DateTime.parse(json['time_finish'] as String),
      user_id: json['user_id'] as String,
      description: json['description'] as String,
      pic_position: json['pic_position'] as String,
      pic_name: json['pic_name'] as String,
      status_visit: json['status_visit'] as String,
    );

Map<String, dynamic> _$VisitToJson(Visit instance) => <String, dynamic>{
      'visit_no': instance.visit_no,
      'visit_id': instance.visit_id,
      'branch_id': instance.branch_id,
      'cust_name': instance.cust_name,
      'cust_id': instance.cust_id,
      'time_start': instance.time_start.toIso8601String(),
      'time_finish': instance.time_finish.toIso8601String(),
      'user_id': instance.user_id,
      'description': instance.description,
      'pic_position': instance.pic_position,
      'pic_name': instance.pic_name,
      'status_visit': instance.status_visit,
    };

VisitResponse _$VisitResponseFromJson(Map<String, dynamic> json) =>
    VisitResponse(
      json['message'] as String,
      (json['result'] as List<dynamic>)
          .map((e) => Visit.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VisitResponseToJson(VisitResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'result': instance.result,
    };

Realization _$RealizationFromJson(Map<String, dynamic> json) => Realization(
      visit_no: json['visit_no'] as String,
      real_no: json['real_no'] as String,
      branch_id: json['branch_id'] as String,
      branch: json['branch'] as String,
      cust_id: json['cust_id'] as String,
      customer: json['customer'] as String,
      time_start: DateTime.parse(json['time_start'] as String),
      time_finish: DateTime.parse(json['time_finish'] as String),
      user_id: json['user_id'] as String,
      employee: json['employee'] as String,
      description: json['description'] as String,
      pic_position: json['pic_position'] as String,
      pic_name: json['pic_name'] as String,
      status_visit: json['status_visit'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      description_real: json['description_real'] as String,
    );

Map<String, dynamic> _$RealizationToJson(Realization instance) =>
    <String, dynamic>{
      'visit_no': instance.visit_no,
      'real_no': instance.real_no,
      'branch_id': instance.branch_id,
      'branch': instance.branch,
      'cust_id': instance.cust_id,
      'customer': instance.customer,
      'time_start': instance.time_start.toIso8601String(),
      'time_finish': instance.time_finish.toIso8601String(),
      'user_id': instance.user_id,
      'employee': instance.employee,
      'description': instance.description,
      'pic_position': instance.pic_position,
      'pic_name': instance.pic_name,
      'status_visit': instance.status_visit,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'description_real': instance.description_real,
    };

RealizationResponse _$RealizationResponseFromJson(Map<String, dynamic> json) =>
    RealizationResponse(
      json['message'] as String,
      (json['result'] as List<dynamic>)
          .map((e) => Realization.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RealizationResponseToJson(
        RealizationResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'result': instance.result,
    };

PostVisit _$PostVisitFromJson(Map<String, dynamic> json) => PostVisit(
      visit_id: json['visit_id'] as String,
      branch_id: json['branch_id'] as String,
      cust_id: json['cust_id'] as String,
      time_start: json['time_start'] as String,
      time_finish: json['time_finish'] as String,
      user_id: json['user_id'] as String,
      description: json['description'] as String,
      pic_position: json['pic_position'] as String,
      pic_name: json['pic_name'] as String,
      status_visit: json['status_visit'] as String,
    );

Map<String, dynamic> _$PostVisitToJson(PostVisit instance) => <String, dynamic>{
      'visit_id': instance.visit_id,
      'branch_id': instance.branch_id,
      'cust_id': instance.cust_id,
      'time_start': instance.time_start,
      'time_finish': instance.time_finish,
      'user_id': instance.user_id,
      'description': instance.description,
      'pic_position': instance.pic_position,
      'pic_name': instance.pic_name,
      'status_visit': instance.status_visit,
    };

PostVisitResponse _$PostVisitResponseFromJson(Map<String, dynamic> json) =>
    PostVisitResponse(
      json['message'] as String,
    );

Map<String, dynamic> _$PostVisitResponseToJson(PostVisitResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

PostReal _$PostRealFromJson(Map<String, dynamic> json) => PostReal(
      visit_no: json['visit_no'] as String,
      branch_id: json['branch_id'] as String,
      cust_id: json['cust_id'] as String,
      time_start: json['time_start'] as String,
      time_finish: json['time_finish'] as String,
      description: json['description'] as String,
      pic_position: json['pic_position'] as String,
      pic_name: json['pic_name'] as String,
      status_visit: json['status_visit'] as String,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
      description_real: json['description_real'] as String,
    );

Map<String, dynamic> _$PostRealToJson(PostReal instance) => <String, dynamic>{
      'visit_no': instance.visit_no,
      'branch_id': instance.branch_id,
      'cust_id': instance.cust_id,
      'time_start': instance.time_start,
      'time_finish': instance.time_finish,
      'description': instance.description,
      'pic_position': instance.pic_position,
      'pic_name': instance.pic_name,
      'status_visit': instance.status_visit,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'description_real': instance.description_real,
    };

PostRealResponse _$PostRealResponseFromJson(Map<String, dynamic> json) =>
    PostRealResponse(
      json['message'] as String,
    );

Map<String, dynamic> _$PostRealResponseToJson(PostRealResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

DeleteVisitResponse _$DeleteVisitResponseFromJson(Map<String, dynamic> json) =>
    DeleteVisitResponse(
      json['message'] as String,
    );

Map<String, dynamic> _$DeleteVisitResponseToJson(
        DeleteVisitResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

Activity _$ActivityFromJson(Map<String, dynamic> json) => Activity(
      in_office: json['in_office'] as String,
      out_office: json['out_office'] as String,
      off_act: json['off_act'] as String,
      all_act: json['all_act'] as String,
      prs_in: json['prs_in'] as String,
      prs_out: json['prs_out'] as String,
      prs_off: json['prs_off'] as String,
    );

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'in_office': instance.in_office,
      'out_office': instance.out_office,
      'off_act': instance.off_act,
      'all_act': instance.all_act,
      'prs_in': instance.prs_in,
      'prs_out': instance.prs_out,
      'prs_off': instance.prs_off,
    };

ActivityResponse _$ActivityResponseFromJson(Map<String, dynamic> json) =>
    ActivityResponse(
      json['message'] as String,
      Activity.fromJson(json['activity'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ActivityResponseToJson(ActivityResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'activity': instance.activity,
    };

Ranking _$RankingFromJson(Map<String, dynamic> json) => Ranking(
      user_id: json['user_id'] as String,
      name_user: json['name_user'] as String,
      branch_id: json['branch_id'] as String,
      branch_name: json['branch_name'] as String,
      in_office: json['in_office'] as String,
      out_office: json['out_office'] as String,
      off_act: json['off_act'] as String,
      all_act: json['all_act'] as String,
    );

Map<String, dynamic> _$RankingToJson(Ranking instance) => <String, dynamic>{
      'user_id': instance.user_id,
      'name_user': instance.name_user,
      'branch_id': instance.branch_id,
      'branch_name': instance.branch_name,
      'in_office': instance.in_office,
      'out_office': instance.out_office,
      'off_act': instance.off_act,
      'all_act': instance.all_act,
    };

RankingResponse _$RankingResponseFromJson(Map<String, dynamic> json) =>
    RankingResponse(
      json['message'] as String,
      (json['ranking'] as List<dynamic>)
          .map((e) => Ranking.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RankingResponseToJson(RankingResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'ranking': instance.ranking,
    };
