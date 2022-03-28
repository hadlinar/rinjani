import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User{
  String user_id;
  String nik;
  String name;
  String branch_id;
  String email;
  String role_id;
  String flg_used;

  User({
    required this.user_id,
    required this.nik,
    required this.name,
    required this.branch_id,
    required this.email,
    required this.role_id,
    required this.flg_used
  });

  factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
}

@JsonSerializable()
class UserResponse{
  String message;
  User result;

  UserResponse(this.message, this.result);

  factory UserResponse.fromJson(Map<String,dynamic> json) => _$UserResponseFromJson(json);
}

@JsonSerializable()
class AllUserResponse{
  String message;
  List<User> result;

  AllUserResponse(this.message, this.result);

  factory AllUserResponse.fromJson(Map<String,dynamic> json) => _$AllUserResponseFromJson(json);
}

