// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerCategory _$CustomerCategoryFromJson(Map<String, dynamic> json) =>
    CustomerCategory(
      category_id: json['category_id'] as String,
      category_name: json['category_name'] as String,
    );

Map<String, dynamic> _$CustomerCategoryToJson(CustomerCategory instance) =>
    <String, dynamic>{
      'category_id': instance.category_id,
      'category_name': instance.category_name,
    };

CustomerCategoryResponse _$CustomerCategoryResponseFromJson(
        Map<String, dynamic> json) =>
    CustomerCategoryResponse(
      json['message'] as String,
      (json['result'] as List<dynamic>)
          .map((e) => CustomerCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CustomerCategoryResponseToJson(
        CustomerCategoryResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'result': instance.result,
    };

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      cust_id: json['cust_id'] as String,
      branch_id: json['branch_id'] as String,
      cust_name: json['cust_name'] as String,
      category_id: json['category_id'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'cust_id': instance.cust_id,
      'branch_id': instance.branch_id,
      'cust_name': instance.cust_name,
      'category_id': instance.category_id,
      'address': instance.address,
      'city': instance.city,
    };

CustomerResponse _$CustomerResponseFromJson(Map<String, dynamic> json) =>
    CustomerResponse(
      json['message'] as String,
      (json['result'] as List<dynamic>)
          .map((e) => Customer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CustomerResponseToJson(CustomerResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'result': instance.result,
    };

NewCustomer _$NewCustomerFromJson(Map<String, dynamic> json) => NewCustomer(
      branch_id: json['branch_id'] as String,
      cust_name: json['cust_name'] as String,
      visit_id: json['visit_id'] as String,
      cust_id: json['cust_id'] as String,
      time_start: json['time_start'] as String,
      time_finish: json['time_finish'] as String,
      user_id: json['user_id'] as String,
      description: json['description'] as String,
      pic_position: json['pic_position'] as String,
      pic_name: json['pic_name'] as String,
      status_visit: json['status_visit'] as String,
    );

Map<String, dynamic> _$NewCustomerToJson(NewCustomer instance) =>
    <String, dynamic>{
      'branch_id': instance.branch_id,
      'cust_name': instance.cust_name,
      'visit_id': instance.visit_id,
      'cust_id': instance.cust_id,
      'time_start': instance.time_start,
      'time_finish': instance.time_finish,
      'user_id': instance.user_id,
      'description': instance.description,
      'pic_position': instance.pic_position,
      'pic_name': instance.pic_name,
      'status_visit': instance.status_visit,
    };

NewCustomerResponse _$NewCustomerResponseFromJson(Map<String, dynamic> json) =>
    NewCustomerResponse(
      json['message'] as String,
    );

Map<String, dynamic> _$NewCustomerResponseToJson(
        NewCustomerResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
    };
