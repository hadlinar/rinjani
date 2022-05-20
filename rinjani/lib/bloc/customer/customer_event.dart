import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CustomerBlocEvent{}

class GetCustomerEvent extends CustomerBlocEvent{
  String id;

  GetCustomerEvent(this.id);
}