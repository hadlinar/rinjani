import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rinjani/data_source/repository/customer_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'customer_state.dart';
import 'customer_event.dart';
import 'customer_bloc.dart';

export 'customer_state.dart';
export 'customer_event.dart';
export 'customer_bloc.dart';

class CustomerBloc extends Bloc<CustomerBlocEvent, CustomerBlocState> {
  final CustomerRepository _customerRepository;

  static create(CustomerRepository customerRepository) => CustomerBloc._(customerRepository);

  CustomerBloc._(this._customerRepository);

  @override
  CustomerBlocState get initialState => InitialCustomerBlocState();

  @override
  Stream<CustomerBlocState> mapEventToState(CustomerBlocEvent event) async* {
      if(event is GetCustomerCategoryEvent) {
        yield* _mapCustomerCategoryToState();
      }
      if(event is GetCustomerEvent) {
        yield* _mapCustomerToState();
      }
  }

  Stream<CustomerBlocState> _mapCustomerCategoryToState() async* {
    yield LoadingCustomerState();
    final response = await _customerRepository.getCustomerCategory();
    yield CustomerCategoryList(response.result);
  }

  Stream<CustomerBlocState> _mapCustomerToState() async* {
    yield LoadingCustomerState();
    final response = await _customerRepository.getCustomer();
    yield CustomerList(response.result);
  }


}