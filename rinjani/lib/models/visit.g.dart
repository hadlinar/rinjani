// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitCategory _$VisitCategoryFromJson(Map<String, dynamic> json) {
  return VisitCategory(
    visit_id: json['visit_id'] as String,
    visit_name: json['visit_name'] as String,
  );
}

Map<String, dynamic> _$VisitCategoryToJson(VisitCategory instance) =>
    <String, dynamic>{
      'visit_id': instance.visit_id,
      'visit_name': instance.visit_name,
    };

VisitCategoryResponse _$VisitCategoryResponseFromJson(
    Map<String, dynamic> json) {
  return VisitCategoryResponse(
    json['message'] as String,
    (json['result'] as List)
        ?.map((e) => e == null
            ? null
            : VisitCategory.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$VisitCategoryResponseToJson(
        VisitCategoryResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'result': instance.result,
    };

VisitReal _$VisitRealFromJson(Map<String, dynamic> json) {
  return VisitReal(
    real_no: json['real_no'] as String,
    visit_no: json['visit_no'] as String,
    branch_id: json['branch_id'] as String,
    cust_id: json['cust_id'] as String,
    time_start: json['time_start'] == null
        ? null
        : DateTime.parse(json['time_start'] as String),
    time_finish: json['time_finish'] == null
        ? null
        : DateTime.parse(json['time_finish'] as String),
    user_id: json['user_id'] as String,
    description: json['description'] as String,
    pic_position: json['pic_position'] as String,
    pic_name: json['pic_name'] as String,
    status_visit: json['status_visit'] as String,
    latitude: (json['latitude'] as num)?.toDouble(),
    longitude: (json['longitude'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$VisitRealToJson(VisitReal instance) => <String, dynamic>{
      'real_no': instance.real_no,
      'visit_no': instance.visit_no,
      'branch_id': instance.branch_id,
      'cust_id': instance.cust_id,
      'time_start': instance.time_start?.toIso8601String(),
      'time_finish': instance.time_finish?.toIso8601String(),
      'user_id': instance.user_id,
      'description': instance.description,
      'pic_position': instance.pic_position,
      'pic_name': instance.pic_name,
      'status_visit': instance.status_visit,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

VisitRealResponse _$VisitRealResponseFromJson(Map<String, dynamic> json) {
  return VisitRealResponse(
    json['message'] as String,
    (json['result'] as List)
        ?.map((e) =>
            e == null ? null : VisitReal.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$VisitRealResponseToJson(VisitRealResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'result': instance.result,
    };

PostVisit _$PostVisitFromJson(Map<String, dynamic> json) {
  return PostVisit(
    visit_cat: json['visit_cat'] as String,
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
}

Map<String, dynamic> _$PostVisitToJson(PostVisit instance) => <String, dynamic>{
      'visit_cat': instance.visit_cat,
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

PostVisitResponse _$PostVisitResponseFromJson(Map<String, dynamic> json) {
  return PostVisitResponse(
    json['message'] as String,
  );
}

Map<String, dynamic> _$PostVisitResponseToJson(PostVisitResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

PostReal _$PostRealFromJson(Map<String, dynamic> json) {
  return PostReal(
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
  );
}

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
    };

PostRealResponse _$PostRealResponseFromJson(Map<String, dynamic> json) {
  return PostRealResponse(
    json['message'] as String,
  );
}

Map<String, dynamic> _$PostRealResponseToJson(PostRealResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

Visit _$VisitFromJson(Map<String, dynamic> json) {
  return Visit(
    visit_no: json['visit_no'] as String,
    visit_cat: json['visit_cat'] as String,
    branch_id: json['branch_id'] as String,
    cust_id: json['cust_id'] as String,
    time_start: json['time_start'] == null
        ? null
        : DateTime.parse(json['time_start'] as String),
    time_finish: json['time_finish'] == null
        ? null
        : DateTime.parse(json['time_finish'] as String),
    user_id: json['user_id'] as String,
    description: json['description'] as String,
    pic_position: json['pic_position'] as String,
    pic_name: json['pic_name'] as String,
    status_visit: json['status_visit'] as String,
  );
}

Map<String, dynamic> _$VisitToJson(Visit instance) => <String, dynamic>{
      'visit_no': instance.visit_no,
      'visit_cat': instance.visit_cat,
      'branch_id': instance.branch_id,
      'cust_id': instance.cust_id,
      'time_start': instance.time_start?.toIso8601String(),
      'time_finish': instance.time_finish?.toIso8601String(),
      'user_id': instance.user_id,
      'description': instance.description,
      'pic_position': instance.pic_position,
      'pic_name': instance.pic_name,
      'status_visit': instance.status_visit,
    };

VisitResponse _$VisitResponseFromJson(Map<String, dynamic> json) {
  return VisitResponse(
    json['message'] as String,
    (json['result'] as List)
        ?.map(
            (e) => e == null ? null : Visit.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$VisitResponseToJson(VisitResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'result': instance.result,
    };

VisitById _$VisitByIdFromJson(Map<String, dynamic> json) {
  return VisitById(
    visit_no: json['visit_no'] as String,
    visit_cat: json['visit_cat'] as String,
    branch_id: json['branch_id'] as String,
    cust_id: json['cust_id'] as String,
    time_start: json['time_start'] == null
        ? null
        : DateTime.parse(json['time_start'] as String),
    time_finish: json['time_finish'] == null
        ? null
        : DateTime.parse(json['time_finish'] as String),
    description: json['description'] as String,
    pic_position: json['pic_position'] as String,
    pic_name: json['pic_name'] as String,
    status_visit: json['status_visit'] as String,
  );
}

Map<String, dynamic> _$VisitByIdToJson(VisitById instance) => <String, dynamic>{
      'visit_no': instance.visit_no,
      'visit_cat': instance.visit_cat,
      'branch_id': instance.branch_id,
      'cust_id': instance.cust_id,
      'time_start': instance.time_start?.toIso8601String(),
      'time_finish': instance.time_finish?.toIso8601String(),
      'description': instance.description,
      'pic_position': instance.pic_position,
      'pic_name': instance.pic_name,
      'status_visit': instance.status_visit,
    };

VisitByIdResponse _$VisitByIdResponseFromJson(Map<String, dynamic> json) {
  return VisitByIdResponse(
    json['message'] as String,
    (json['result'] as List)
        ?.map((e) =>
            e == null ? null : VisitById.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$VisitByIdResponseToJson(VisitByIdResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'result': instance.result,
    };

VisitRealById _$VisitRealByIdFromJson(Map<String, dynamic> json) {
  return VisitRealById(
    real_no: json['real_no'] as String,
    visit_no: json['visit_no'] as String,
    branch_id: json['branch_id'] as String,
    cust_id: json['cust_id'] as String,
    time_start: json['time_start'] == null
        ? null
        : DateTime.parse(json['time_start'] as String),
    time_finish: json['time_finish'] == null
        ? null
        : DateTime.parse(json['time_finish'] as String),
    description: json['description'] as String,
    pic_position: json['pic_position'] as String,
    pic_name: json['pic_name'] as String,
    status_visit: json['status_visit'] as String,
    latitude: (json['latitude'] as num)?.toDouble(),
    longitude: (json['longitude'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$VisitRealByIdToJson(VisitRealById instance) =>
    <String, dynamic>{
      'real_no': instance.real_no,
      'visit_no': instance.visit_no,
      'branch_id': instance.branch_id,
      'cust_id': instance.cust_id,
      'time_start': instance.time_start?.toIso8601String(),
      'time_finish': instance.time_finish?.toIso8601String(),
      'description': instance.description,
      'pic_position': instance.pic_position,
      'pic_name': instance.pic_name,
      'status_visit': instance.status_visit,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

VisitRealByIdResponse _$VisitRealByIdResponseFromJson(
    Map<String, dynamic> json) {
  return VisitRealByIdResponse(
    json['message'] as String,
    (json['result'] as List)
        ?.map((e) => e == null
            ? null
            : VisitRealById.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$VisitRealByIdResponseToJson(
        VisitRealByIdResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'result': instance.result,
    };
