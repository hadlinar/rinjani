import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CustomerCatBlocEvent{}

class GetCustomerCategoryEvent extends CustomerCatBlocEvent{}