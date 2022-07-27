// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employee _$EmployeeFromJson(Map<String, dynamic> json) => Employee(
      nik: json['nik'] as String,
      branch_id: json['branch_id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$EmployeeToJson(Employee instance) => <String, dynamic>{
      'nik': instance.nik,
      'branch_id': instance.branch_id,
      'name': instance.name,
    };

EmployeeResponse _$EmployeeResponseFromJson(Map<String, dynamic> json) =>
    EmployeeResponse(
      json['message'] as String,
      (json['result'] as List<dynamic>)
          .map((e) => Employee.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EmployeeResponseToJson(EmployeeResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'result': instance.result,
    };

EmployeeBranchResponse _$EmployeeBranchResponseFromJson(
        Map<String, dynamic> json) =>
    EmployeeBranchResponse(
      json['message'] as String,
      (json['result'] as List<dynamic>)
          .map((e) => Employee.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EmployeeBranchResponseToJson(
        EmployeeBranchResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'result': instance.result,
    };
