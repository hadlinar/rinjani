import 'package:json_annotation/json_annotation.dart';
part 'employee.g.dart';

// "nik": "1984409004",
// "branch_id": "11",
// "name": "ISKAK PUTRA"

@JsonSerializable()
class Employee{
  static const SUCCESS_LOCATION = "ok";

  String nik;
  String branch_id;
  String name;

  Employee({
    required this.nik,
    required this.branch_id,
    required this.name
  });

  factory Employee.fromJson(Map<String,dynamic> json) => _$EmployeeFromJson(json);
}

@JsonSerializable()
class EmployeeResponse{
  String message;
  List<Employee> result;

  EmployeeResponse(this.message, this.result);

  factory EmployeeResponse.fromJson(Map<String,dynamic> json) => _$EmployeeResponseFromJson(json);
}