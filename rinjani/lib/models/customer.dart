import 'package:json_annotation/json_annotation.dart';
part 'customer.g.dart';

@JsonSerializable()
class CustomerCategory{
  static const SUCCESS_LOCATION = "ok";

  String category_id;
  String category_name;

  CustomerCategory({required this.category_id, required this.category_name});

  factory CustomerCategory.fromJson(Map<String,dynamic> json) => _$CustomerCategoryFromJson(json);
}

@JsonSerializable()
class CustomerCategoryResponse{
  String message;
  List<CustomerCategory> result;

  CustomerCategoryResponse(this.message, this.result);

  factory CustomerCategoryResponse.fromJson(Map<String,dynamic> json) => _$CustomerCategoryResponseFromJson(json);
}

@JsonSerializable()
class Customer{
  static const SUCCESS_LOCATION = "ok";

  String cust_id;
  String branch_id;
  String cust_name;
  String category_id;
  String address;
  String city;

  Customer({
    required this.cust_id,
    required this.branch_id,
    required this.cust_name,
    required this.category_id,
    required this.address,
    required this.city,
  });

  factory Customer.fromJson(Map<String,dynamic> json) => _$CustomerFromJson(json);
}

@JsonSerializable()
class CustomerResponse{
  String message;
  List<Customer> result;

  CustomerResponse(this.message, this.result);

  factory CustomerResponse.fromJson(Map<String,dynamic> json) => _$CustomerResponseFromJson(json);
}