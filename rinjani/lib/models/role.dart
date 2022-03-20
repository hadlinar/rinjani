import 'package:json_annotation/json_annotation.dart';
part 'role.g.dart';

@JsonSerializable()
class Role{
  static const SUCCESS_LOCATION = "ok";

  String role_id;
  String role_name;

  Role({required this.role_id, required this.role_name});

  factory Role.fromJson(Map<String,dynamic> json) => _$RoleFromJson(json);
}

@JsonSerializable()
class RoleResponse{
  String message;
  List<Role> result;

  RoleResponse(this.message, this.result);

  factory RoleResponse.fromJson(Map<String,dynamic> json) => _$RoleResponseFromJson(json);
}