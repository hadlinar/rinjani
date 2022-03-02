import 'package:rinjani/models/customer.dart';

import '../network/customer_service.dart';

class CustomerRepository {
  final CustomerService customerService;

  CustomerRepository(this.customerService);

  Future<CustomerCategoryResponse> getCustomerCategory() async {
    final response = await customerService.getCustomerCategory();

    return response;
  }

  Future<CustomerResponse> getCustomer() async {
    final response = await customerService.getCustomer();

    return response;
  }

}