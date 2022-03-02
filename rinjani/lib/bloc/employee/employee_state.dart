import 'package:meta/meta.dart';

import '../../models/employee.dart';

@immutable
abstract class EmployeeBlocState {}

class InitialEmployeeBlocState extends EmployeeBlocState {}

class LoadingEmployeeState extends EmployeeBlocState{}

class SuccesssEmployeeState extends EmployeeBlocState{}

class FailedEmployeeState extends EmployeeBlocState{}

class EmployeeList extends EmployeeBlocState{
  List<Employee> getEmployee;

  EmployeeList(this.getEmployee);
}

