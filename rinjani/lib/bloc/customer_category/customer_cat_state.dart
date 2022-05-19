import 'package:meta/meta.dart';

import '../../models/customer.dart';

@immutable
abstract class CustomerCatBlocState {}

class InitialCustomerCatBlocState extends CustomerCatBlocState {}

class LoadingCustomerCatState extends CustomerCatBlocState{}

class SuccessCustomerCatState extends CustomerCatBlocState{}

class FailedCustomerCatState extends CustomerCatBlocState{}

class CustomerCategoryList extends CustomerCatBlocState{
  List<CustomerCategory> getCustomerCategory;

  CustomerCategoryList(this.getCustomerCategory);
}
