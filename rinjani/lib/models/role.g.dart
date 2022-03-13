// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Role _$RoleFromJson(Map<String, dynamic> json) {
  return Role(
    role_id: json['role_id'] as String,
    role_name: json['role_name'] as String,
  );
}

Map<String, dynamic> _$RoleToJson(Role instance) => <String, dynamic>{
      'role_id': instance.role_id,
      'role_name': instance.role_name,
    };

RoleResponse _$RoleResponseFromJson(Map<String, dynamic> json) {
  return RoleResponse(
    json['message'] as String,
    (json['result'] as List)
        ?.map(
            (e) => e == null ? null : Role.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RoleResponseToJson(RoleResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'result': instance.result,
    };
