import 'package:json_annotation/json_annotation.dart';
part 'branch.g.dart';

@JsonSerializable()
class Branch{
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

// "branch_id": "0",
// "branch_name": "ALL CABANG"

@JsonSerializable()
class BranchOp{
  String branch_id;
  String branch_name;

  BranchOp({
    required this.branch_id,
    required this.branch_name,
  });

  factory BranchOp.fromJson(Map<String,dynamic> json) => _$BranchOpFromJson(json);
}

@JsonSerializable()
class BranchOpResponse {
  String message;
  List<BranchOp> result;

  BranchOpResponse(this.message, this.result);

  factory BranchOpResponse.fromJson(Map<String, dynamic> json) => _$BranchOpResponseFromJson(json);
}