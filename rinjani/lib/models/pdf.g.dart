// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PDF _$PDFFromJson(Map<String, dynamic> json) => PDF(
      json['real_no'] as String,
      json['visit_no'] as String,
      json['branch_id'] as String,
      json['branch'] as String,
      json['cust_id'] as String,
      json['customer'] as String,
      json['email'] as String,
      json['time_start'] as String,
      json['time_finish'] as String,
      json['user_id'] as String,
      json['employee'] as String,
      json['description_real'] as String,
      json['pic_position'] as String,
      json['pic_name'] as String,
    );

Map<String, dynamic> _$PDFToJson(PDF instance) => <String, dynamic>{
      'real_no': instance.real_no,
      'visit_no': instance.visit_no,
      'branch_id': instance.branch_id,
      'branch': instance.branch,
      'cust_id': instance.cust_id,
      'customer': instance.customer,
      'email': instance.email,
      'time_start': instance.time_start,
      'time_finish': instance.time_finish,
      'user_id': instance.user_id,
      'employee': instance.employee,
      'description_real': instance.description_real,
      'pic_position': instance.pic_position,
      'pic_name': instance.pic_name,
    };

PDFResponse _$PDFResponseFromJson(Map<String, dynamic> json) => PDFResponse(
      json['message'] as String,
      (json['result'] as List<dynamic>)
          .map((e) => PDF.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PDFResponseToJson(PDFResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'result': instance.result,
    };
