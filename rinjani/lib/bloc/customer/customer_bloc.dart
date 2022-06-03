import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rinjani/data_source/repository/customer_repository.dart';

import 'customer_bloc.dart';

export 'customer_state.dart';
export 'customer_event.dart';
export 'customer_bloc.dart';

class CustomerBloc extends Bloc<CustomerBlocEvent, CustomerBlocState> {
  final CustomerRepository _customerRepository;

  static create(CustomerRepository visitRepository) => CustomerBloc._(visitRepository);

  CustomerBloc._(this._customerRepository);

  @override
  CustomerBlocState get initialState => InitialCustomerBlocState();

  @override
  Stream<CustomerBlocState> mapEventToState(CustomerBlocEvent event) async* {
    if(event is GetCustomerEvent) {
      yield* _mapCustomerToState(event);
    }
  }

  Stream<CustomerBlocState> _mapCustomerToState(GetCustomerEvent e) async* {
    yield LoadingCustomerState();
    final response = await _customerRepository.getCustomer(e.id);
    yield CustomerList(response.result);
  }
}