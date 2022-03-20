import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class EmployeeBlocEvent{}

class GetEmployeeEvent extends EmployeeBlocEvent{}