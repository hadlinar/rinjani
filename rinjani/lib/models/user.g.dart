// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      user_id: json['user_id'] as String,
      nik: json['nik'] as String,
      name: json['name'] as String,
      branch_id: json['branch_id'] as String,
      email: json['email'] as String,
      role_id: json['role_id'] as String,
      flg_used: json['flg_used'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'user_id': instance.user_id,
      'nik': instance.nik,
      'name': instance.name,
      'branch_id': instance.branch_id,
      'email': instance.email,
      'role_id': instance.role_id,
      'flg_used': instance.flg_used,
    };

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      json['message'] as String,
      User.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'result': instance.result,
    };

AllUserResponse _$AllUserResponseFromJson(Map<String, dynamic> json) =>
    AllUserResponse(
      json['message'] as String,
      (json['result'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllUserResponseToJson(AllUserResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'result': instance.result,
    };
