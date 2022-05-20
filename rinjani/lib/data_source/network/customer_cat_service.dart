import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../models/customer.dart';
import '../../utils/global.dart';

part 'customer_cat_service.g.dart';

@RestApi(baseUrl: Global.baseURL)

abstract class CustomerCatService{
  static create(Dio dio) => _CustomerCatService(dio);

  @GET('/customers/category')
  Future<CustomerCategoryResponse> getCustomerCategory();

}