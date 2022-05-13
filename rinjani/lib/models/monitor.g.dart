// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monitor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Monitor _$MonitorFromJson(Map<String, dynamic> json) => Monitor(
      json['branch_id'] as String,
      json['branch_name'] as String,
      json['in_office'] as String,
      json['out_office'] as String,
      json['off_act'] as String,
      json['all_act'] as String,
    );

Map<String, dynamic> _$MonitorToJson(Monitor instance) => <String, dynamic>{
      'branch_id': instance.branch_id,
      'branch_name': instance.branch_name,
      'in_office': instance.in_office,
      'out_office': instance.out_office,
      'off_act': instance.off_act,
      'all_act': instance.all_act,
    };

MonitorResponse _$MonitorResponseFromJson(Map<String, dynamic> json) =>
    MonitorResponse(
      json['message'] as String,
      (json['result'] as List<dynamic>)
          .map((e) => Monitor.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MonitorResponseToJson(MonitorResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'result': instance.result,
    };
