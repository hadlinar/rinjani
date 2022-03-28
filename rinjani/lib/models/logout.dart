import 'package:json_annotation/json_annotation.dart';

part 'logout.g.dart';

@JsonSerializable()
class LogoutResponse{
  String message;

  LogoutResponse(this.message);

  factory LogoutResponse.fromJson(Map<String,dynamic> json) => _$LogoutResponseFromJson(json);
}