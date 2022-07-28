// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ranking _$RankingFromJson(Map<String, dynamic> json) => Ranking(
      json['branch_id'] as String,
      json['branch_name'] as String,
      json['position'] as String,
      json['nik'] as String,
      json['name_emp'] as String,
      json['in_office'] as String,
      json['out_office'] as String,
      json['off_act'] as String,
      json['all_act'] as String,
    );

Map<String, dynamic> _$RankingToJson(Ranking instance) => <String, dynamic>{
      'branch_id': instance.branch_id,
      'branch_name': instance.branch_name,
      'position': instance.position,
      'nik': instance.nik,
      'name_emp': instance.name_emp,
      'in_office': instance.in_office,
      'out_office': instance.out_office,
      'off_act': instance.off_act,
      'all_act': instance.all_act,
    };

RankingResponse _$RankingResponseFromJson(Map<String, dynamic> json) =>
    RankingResponse(
      json['message'] as String,
      (json['result'] as List<dynamic>)
          .map((e) => Ranking.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RankingResponseToJson(RankingResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'result': instance.result,
    };
