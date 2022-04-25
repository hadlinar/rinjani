import 'package:rinjani/models/customer.dart';

import '../network/customer_service.dart';

class CustomerRepository {
  final CustomerService customerService;

  CustomerRepository(this.customerService);

  Future<CustomerCategoryResponse> getCustomerCategory() async {
    final response = await customerService.getCustomerCategory();

    return response;
  }

  Future<CustomerResponse> getCustomer(String id) async {
    final response = await customerService.getCustomer(id);
    return response;
  }

  Future<NewCustomerResponse> addCustomer({
    required String branch_id,
    required String cust_name
  }) async {
    final response = await customerService.addCustomer({
      "branch_id": branch_id,
      "cust_name": cust_name
    });
    return response;
  }

}