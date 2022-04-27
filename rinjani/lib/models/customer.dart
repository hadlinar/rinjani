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

@JsonSerializable()
class NewCustomer{
  String branch_id;
  String cust_name;
  String visit_id;
  String cust_id;
  String time_start;
  String time_finish;
  String user_id;
  String description;
  String pic_position;
  String pic_name;
  String status_visit;

  NewCustomer({
    required this.branch_id,
    required this.cust_name,
    required this.visit_id,
    required this.cust_id,
    required this.time_start,
    required this.time_finish,
    required this.user_id,
    required this.description,
    required this.pic_position,
    required this.pic_name,
    required this.status_visit,
  });

  factory NewCustomer.fromJson(Map<String,dynamic> json) => _$NewCustomerFromJson(json);
}

@JsonSerializable()
class NewCustomerResponse{
  String message;

  NewCustomerResponse(this.message);

  factory NewCustomerResponse.fromJson(Map<String,dynamic> json) => _$NewCustomerResponseFromJson(json);
}