import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rinjani/data_source/repository/customer_repository.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data_source/repository/customer_cat_repository.dart';
import 'customer_cat_state.dart';
import 'customer_cat_event.dart';
import 'customer_cat_bloc.dart';

export 'customer_cat_state.dart';
export 'customer_cat_event.dart';
export 'customer_cat_bloc.dart';

class CustomerCatBloc extends Bloc<CustomerCatBlocEvent, CustomerCatBlocState> {
  final CustomerCatRepository _customerCatRepository;

  static create(CustomerCatRepository customerCatRepository) => CustomerCatBloc._(customerCatRepository);

  CustomerCatBloc._(this._customerCatRepository);

  @override
  CustomerCatBlocState get initialState => InitialCustomerCatBlocState();

  @override
  Stream<CustomerCatBlocState> mapEventToState(CustomerCatBlocEvent event) async* {
    if(event is GetCustomerCategoryEvent) {
      yield* _mapCustomerCategoryToState();
    }
  }

  Stream<CustomerCatBlocState> _mapCustomerCategoryToState() async* {
    yield LoadingCustomerCatState();
    final response = await _customerCatRepository.getCustomerCategory();
    yield CustomerCategoryList(response.result);
  }
}