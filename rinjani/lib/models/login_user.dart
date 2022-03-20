import 'package:json_annotation/json_annotation.dart';

import 'package:rinjani/models/user.dart';
part 'login_user.g.dart';

@JsonSerializable()
class Login{
  String nik;
  String password;

  Login({
    required this.nik,
    required this.password,
  });

  factory Login.fromJson(Map<String,dynamic> json) => _$LoginFromJson(json);
}

@JsonSerializable()
class LoginResponse{
  String message;
  String token;
  UserToken user;

  LoginResponse(this.message, this.token, this.user);

  factory LoginResponse.fromJson(Map<String,dynamic> json) => _$LoginResponseFromJson(json);
}