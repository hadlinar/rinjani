import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CustomerBlocEvent{}

class GetCustomerCategoryEvent extends CustomerBlocEvent{}

class GetCustomerEvent extends CustomerBlocEvent{
  String id;

  GetCustomerEvent(this.id);
}

class AddCustomerEvent extends CustomerBlocEvent{
  final String branch_id;
  final String cust_name;

  AddCustomerEvent(
    this.branch_id,
    this.cust_name
  );
}