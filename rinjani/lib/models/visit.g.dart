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
