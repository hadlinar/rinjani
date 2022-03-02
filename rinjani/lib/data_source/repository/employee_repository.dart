import '../../models/employee.dart';
import '../network/employee_service.dart';

class EmployeeRepository {
  final EmployeeService employeeService;

  EmployeeRepository(this.employeeService);

  Future<EmployeeResponse> getEmployee() async {
    final response = await employeeService.getEmployee();
    return response;
  }

}