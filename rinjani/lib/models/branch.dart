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
    this.branch_id,
    this.branch_name,
    this.nick_name,
    this.address,
  });

  factory Branch.fromJson(Map<String,dynamic> json) => _$BranchFromJson(json);
}

@JsonSerializable()
class BranchResponse{
  String message;
  List<Branch> result;

  BranchResponse(this.message, this.result);

  factory BranchResponse.fromJson(Map<String,dynamic> json) => _$BranchResponseFromJson(json);
}