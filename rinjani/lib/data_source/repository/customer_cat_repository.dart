import 'package:rinjani/models/customer.dart';

import '../network/customer_cat_service.dart';

class CustomerCatRepository {
  final CustomerCatService customerCatService;

  CustomerCatRepository(this.customerCatService);

  Future<CustomerCategoryResponse> getCustomerCategory() async {
    final response = await customerCatService.getCustomerCategory();
    return response;
  }

}