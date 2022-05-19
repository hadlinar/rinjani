import 'package:meta/meta.dart';

import '../../models/customer.dart';

@immutable
abstract class CustomerBlocState {}

class InitialCustomerBlocState extends CustomerBlocState {}

class LoadingCustomerState extends CustomerBlocState{}

class SuccesssCustomerState extends CustomerBlocState{}

class FailedCustomerState extends CustomerBlocState{}

class CustomerList extends CustomerBlocState{
  List<Customer> getCustomer;

  CustomerList(this.getCustomer);
}
