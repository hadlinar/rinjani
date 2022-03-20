import 'package:json_annotation/json_annotation.dart';
part 'employee.g.dart';


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