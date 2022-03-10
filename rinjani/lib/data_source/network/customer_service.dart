import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../models/customer.dart';
import '../../utils/global.dart';

part 'customer_service.g.dart';

@RestApi(baseUrl: Global.baseURL)

abstract class CustomerService{
  static create(Dio dio, {required String baseUrl}) => _CustomerService(dio, baseUrl: baseUrl);

  @GET('/customer/category')
  Future<CustomerCategoryResponse> getCustomerCategory();

  @GET('/customer')
  Future<CustomerResponse> getCustomer();
}
