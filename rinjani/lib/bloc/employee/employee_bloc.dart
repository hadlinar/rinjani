import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_source/repository/employee_repository.dart';

import 'employee_state.dart';
import 'employee_event.dart';
import 'employee_bloc.dart';

export 'employee_state.dart';
export 'employee_event.dart';
export 'employee_bloc.dart';

class EmployeeBloc extends Bloc<EmployeeBlocEvent, EmployeeBlocState> {
  final EmployeeRepository _employeeRepository;

  static create(EmployeeRepository employeeRepository) => EmployeeBloc._(employeeRepository);

  EmployeeBloc._(this._employeeRepository);

  @override
  EmployeeBlocState get initialState => InitialEmployeeBlocState();

  @override
  Stream<EmployeeBlocState> mapEventToState(EmployeeBlocEvent event) async* {
    if(event is GetEmployeeEvent) {
      yield* _mapEmployeeToState();
    }
  }

  Stream<EmployeeBlocState> _mapEmployeeToState() async* {
    yield LoadingEmployeeState();
    final response = await _employeeRepository.getEmployee();
    yield EmployeeList(response.result);
  }
}