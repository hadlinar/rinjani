import 'package:json_annotation/json_annotation.dart';
part 'branch.g.dart';

@JsonSerializable()
class Branch{
  static const SUCCESS_LOCATION = "ok";

  String branch_id;
  String branch_name;
  String nick_name;
  String address;

  Branch({
    required this.branch_id,
    required this.branch_name,
    required this.nick_name,
    required this.address,
  });

  factory Branch.fromJson(Map<String,dynamic> json) => _$BranchFromJson(json);
}

@JsonSerializable()
class BranchResponse {
  String message;
  List<Branch> result;

  BranchResponse(this.message, this.result);

  factory BranchResponse.fromJson(Map<String, dynamic> json) =>
      _$BranchResponseFromJson(json);
}