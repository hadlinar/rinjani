import 'package:json_annotation/json_annotation.dart';

import 'package:rinjani/models/user.dart';
part 'login.g.dart';

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

  LoginResponse(this.message, this.token);

  factory LoginResponse.fromJson(Map<String,dynamic> json) => _$LoginResponseFromJson(json);
}