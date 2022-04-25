import 'package:meta/meta.dart';

import '../../models/customer.dart';

@immutable
abstract class CustomerBlocState {}

class InitialCustomerBlocState extends CustomerBlocState {}

class LoadingCustomerState extends CustomerBlocState{}

class SuccesssCustomerState extends CustomerBlocState{}

class FailedCustomerState extends CustomerBlocState{}

class CustomerCategoryList extends CustomerBlocState{
  List<CustomerCategory> getCustomerCategory;

  CustomerCategoryList(this.getCustomerCategory);
}

class CustomerList extends CustomerBlocState{
  List<Customer> getCustomer;

  CustomerList(this.getCustomer);
}

class SuccessAddCustomer extends CustomerBlocState{}
