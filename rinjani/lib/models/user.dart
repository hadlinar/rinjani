import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

// "user_id": "1984409004",
// "nik": "1984409004",
// "branch_id": "11",
// "password": "$2y$10$XPm1TQruFZv1gEy9PShrkePa4qVWEauJJZ7viambJ0f.xlcWlIhT2",
// "email": "iskak@nusindo.co.id",
// "role_id": "2",
// "flg_used": "y"

@JsonSerializable()
class User{
  static const SUCCESS_LOCATION = "ok";

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
  List<User> result;

  UserResponse(this.message, this.result);

  factory UserResponse.fromJson(Map<String,dynamic> json) => _$UserResponseFromJson(json);
}

@JsonSerializable()
class UserToken{
  static const SUCCESS_LOCATION = "ok";

  String user_id;
  String name;
  String nik;
  String branch_id;
  String email;
  String role_id;
  String flg_used;

  UserToken({
    required this.user_id,
    required this.name,
    required this.nik,
    required this.branch_id,
    required this.email,
    required this.role_id,
    required this.flg_used
  });

  factory UserToken.fromJson(Map<String,dynamic> json) => _$UserTokenFromJson(json);
}

@JsonSerializable()
class UserTokenResponse{
  String message;
  String token;
  UserToken result;

  UserTokenResponse(this.message, this.token, this.result);

  factory UserTokenResponse.fromJson(Map<String,dynamic> json) => _$UserTokenResponseFromJson(json);
}

